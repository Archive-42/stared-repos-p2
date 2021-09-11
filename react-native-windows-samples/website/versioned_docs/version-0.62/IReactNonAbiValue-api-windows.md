---
id: version-0.62-ireactnonabivalue-api
title: IReactNonAbiValue
original_id: ireactnonabivalue-api
---

IReactNonAbiValue helps to wrap up a non-ABI safe C++ values into an IInspectable object. We use it to handle native module lifetime.

It also can be used to store values in the IReactPropertyBag that do not need to go through the EXE/DLL boundary.

# Reference

## Methods

### ```Int64 GetPtr();```

Get a pointer to the stored value.

<!-- // Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

namespace Microsoft.ReactNative {

  // IReactNonAbiValue helps to wrap up a non-ABI safe C++ values into an
  // IInspectable object. We use it to handle native module lifetime.
  // It also can be used to store values in the IReactPropertyBag that do not
  // need to go through the EXE/DLL boundary.
  [webhosthidden]
  interface IReactNonAbiValue
  {
    // Get a pointer to the stored value.
    Int64 GetPtr();
  }
} // namespace Microsoft.ReactNative -->
