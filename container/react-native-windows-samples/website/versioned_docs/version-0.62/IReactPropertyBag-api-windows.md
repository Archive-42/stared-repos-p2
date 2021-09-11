---
id: version-0.62-ireactpropertybag-api
title: IReactPropertyBag
original_id: ireactpropertybag-api
---

The IReactPropertyBag provides a thread-safe property storage.
Properties are identified by IReactPropertyName instance.
It is expected that there will be no direct use of this interface.
Ideally, all usage should happen through a strongly typed accessors.

# Reference

## Methods

### ```Object Get(IReactPropertyName name)```

Get property value by its name. It returns null if the property does not exist.

### ```Object GetOrCreate(IReactPropertyName name, ReactCreatePropertyValue createValue)```

Get property value for the property name. If the property does not exist, then create it by calling createValue delegate.

The function may return null if the createValue returns null when called.

The createValue is called outside of lock. It is possible that its result is not used in case if other thread sets the property value before the created value is applied.

### ```Object Set(IReactPropertyName name, Object value)```

Set property value for the property name.

It returns previously stored property value.
It returns null if property did not exist.
If the new value is null, then the property is removed.

## Delegates

### ```delegate Object ReactCreatePropertyValue()```

The delegate is used to create property value on-demand.


<!-- 

  // The delegate is used to create property value on-demand.
  [webhosthidden]
  delegate Object ReactCreatePropertyValue();

  // The IReactPropertyBag provides a thread-safe property storage.
  // Properties are identified by IReactPropertyName instance.
  // It is expected that there will be no direct use of this interface.
  // Ideally, all usage should happen through a strongly typed accessors.
  [webhosthidden]
  interface IReactPropertyBag
  {
    // Get property value by its name. It returns null if the property does not exist.
    Object Get(IReactPropertyName name);

    // Get property value for the property name.
    // If the property does not exist, then create it by calling createValue delegate.
    // The function may return null if the createValue returns null when called.
    // The createValue is called outside of lock. It is possible that its
    // result is not used in case if other thread sets the property value before
    // the created value is applied.
    Object GetOrCreate(IReactPropertyName name, ReactCreatePropertyValue createValue);

    // Set property value for the property name.
    // It returns previously stored property value.
    // It returns null if property did not exist.
    // If the new value is null, then the property is removed.
    Object Set(IReactPropertyName name, Object value);
  } -->


<!-- NOTE: The following types are not documented on this page. -->

<!-- 
namespace Microsoft.ReactNative {

  // Namespace for the property name.
  // Use ReactPropertyBagHelper.GetNamespace to get atomic property namespace for a string.
  [webhosthidden]
  interface IReactPropertyNamespace
  {
    // Get String name representation of the property namespace.
    String NamespaceName { get; };
  }

  // Name of a property.
  // Use ReactPropertyBagHelper.GetName to get atomic property name for a string.
  [webhosthidden]
  interface IReactPropertyName
  {
    // The local property name String in context of the property namespace.
    String LocalName { get; };

    // The namespace the property name is defined in.
    IReactPropertyNamespace Namespace { get; };
  } -->

<!-- 
  // Helper methods for the property bag implementation.
  [webhosthidden]
  static runtimeclass ReactPropertyBagHelper
  {
    // Return a global namespace that corresponds to an empty string.
    static IReactPropertyNamespace GlobalNamespace { get; };

    // Get an atomic IReactPropertyNamespace for a provided namespaceName.
    // Consider to use module name as a namespace for module-specific properties.
    static IReactPropertyNamespace GetNamespace(String namespaceName);

    // Get atomic IReactPropertyName for the namespace and local name.
    // If ns is null, then it uses IReactPropertyNamespace.GlobalNamespace.
    static IReactPropertyName GetName(IReactPropertyNamespace ns, String localName);

    // Create new instance of IReactPropertyBag
    static IReactPropertyBag CreatePropertyBag();
  }
} // namespace Microsoft.ReactNative  -->
