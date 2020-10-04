---
title: 'ES6 Maps, Weak Maps, and the Determinism of the JavaScript Garbage Collector'
tags: 'JS, ES6'
date: 2016-07-09 18:13:42
layout: post
---


Let's say you have an app with a number of objects, and you'd like to store metadata about certain objects. How would you do this? What I've been doing is creating a special object for the purpose, like so:

```javascript
var x = { uniqueIdentifier : "this is my first object" };
var y = { uniqueIdentifier : "this is my second object" };

var registry = {};

registry[x.uniqueIdentifier] = 'this object is okay';
registry[y.uniqueIdentifier] = 'but this object is my favorite!';

for (var i in registry) {
  console.log(i + ': ' + registry[i]);
}
```

Here we have two objects, `x` and `y`, which we'd like to keep metadata about in a variable called `registry`. We use as the key for each entry in our registry the object in question's "uniqueIdentifier" property. Now, at any later time, if we'd like to access the metadata about an object, all we need to know is the value of the object's "uniqueIdentifier" property.

Restrictions for this method are:

1. Every object that will be stored in the registry should have a common property with the same key name, here called "uniqueIdentifier".
2. Each object must have a unique value to this property, or else registry entries will get overwritten.
3. The value to this property must be a string, because the key names for our registry object must be strings.

A workaround for the last two would be creating a hashing function, but this must be deterministic (i.e. it must be repeatable, or else we would not be able to consistently look up this value in the future). Somehow the values of each object to be tracked in the registry must be unique.

An example of restriction 2 is as follows:

```javascript
var x = { firstName : 'Michael', lastName : 'Jordan' };
var y = { firstName : 'Michael', lastName : 'Jackson' };
var z = { firstName : 'Andrew', lastName : 'Jackson' };

var registry = {};

registry[x.firstName] = 'a basketball player';
registry[y.firstName] = 'a musician';
registry[z.firstName] = 'a US president';

console.log(x.firstName + ' ' + x.lastName + ' was ' + registry.x.firstName + '.');
```

Here the metadata for Michael Jordan been overwritten by that for Michael Jackson because we used `firstName` as our registry key. Here we would have the same problem if we used `lastName`, because it is not universally unique either. In this example we could create unique identifiers by concatenating the first and last names, but there might be objects where these are the same too, and this would be more of a bandage on the problem than an true solution.

This is essentially JavaScript's makeshift equivalent of a [hash map](https://en.wikipedia.org/wiki/Hash_table).

## ES2015 Maps

With ES2015, we now have a new native, built-in object for handling these kinds of maps, unsurprisingly called `Map`. Here's our previous example, re-written using an ES2015 map:

```javascript
var x = { firstName : 'Michael', lastName : 'Jordan' };
var y = { firstName : 'Michael', lastName : 'Jackson' };
var z = { firstName : 'Andrew', lastName : 'Jackson' };

var registry = new Map();

registry.set(x, 'a basketball player');
registry.set(y, 'a musician');
registry.set(z, 'a US president');

console.log(x.firstName + ' ' + x.lastName + ' was ' + registry.get(x) + '.');
```

Here we called the native `Map` object's constructor to create our registry (we could have initialized our registry by passing an array of arrays of key-value pairs to the constructor, but this method is more directly analogous to our previous example). The [Map.prototype.set() method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map/set) takes a key-value pair as its arguments. And—as you can see from our example—map keys don't have to be strings, they can be any valid JavaScript type, including objects (technically a reference to the object). So rather than having to use some unique identifier to specify each object in our registry, we can use a reference to the object itself as the key. This essentially removes our previous 3 restrictions.

A neat bonus of this is that we can separately track objects that have the exact same values. For example:

```javascript
var x = { firstName : 'Chris' };
var y = { firstName : 'Chris' };

var registry = new Map();

registry.set(x, 'an eager student of JavaScript');
registry.set(y, 'Thor');

x.lastName = 'Fujino';
y.lastName = 'Hemsworth';

console.log(x.firstName + ' ' + x.lastName + ' is ' + registry.get(x));
```

Even though the contents of `x` and `y` are the same at the time registry.set() is called, they produce distinct entries because the map uses references to the two objects as its keys.

## WeakMaps

Maps are really cool, but they produce a potential memory leak because if you store a reference to a certain object as a map key, that object will not be garbage collected, even if it's no longer referenced elsewhere in your code. Map properties can be manually deleted with [Map.prototype.delete(key)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map/delete), but you would have to keep track of this yourself, and works counterintuitive to [the way JavaScript handles memory management](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management).

Thus, ES2016 also has WeakMaps, which are similar to Maps with the following differences:

1. WeakMap key entries must be object references
2. These references will not interfere with garbage collection. Thus, if a reference to an object is used as a WeakMap key but that object is no longer referenced elsewhere, the garbage collector will remove that object and also its WeakMap property.
3. Though maps have a built-in Map.prototype.size property, since we're never quite sure when garbage collection will happen, WeakMaps don't have this property. They also don't have a .forEach() method as—again—its contents are not deterministic.

Here's an example implementation:

```javascript
var x = { name : 'my first object' };
var y = { name : 'my second object'};

var wm = new WeakMap([
  [x, 'metadata about x'],
  [y, 'metadata about y']
]);

(function(){  // This IIFE creates an isolated scope
  var z = { name : 'my third object' };
  wm.set(z, 'metadata about z');
})();

z;          // here z is no longer in scope, we can't access it
wm.get(z);  // will this return metadata about z? can't be sure
```
