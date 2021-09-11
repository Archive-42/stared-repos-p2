---
id: version-0.65-ReactCoreInjection
title: ReactCoreInjection
original_id: ReactCoreInjection
---

Kind: `class`



> **EXPERIMENTAL**

Used to inject platform specific implementations to create react-native targets targeting non-XAML platforms.



## Methods
### MakeViewHost
`static` [`IReactViewHost`](IReactViewHost) **`MakeViewHost`**([`ReactNativeHost`](ReactNativeHost) host, [`ReactViewOptions`](ReactViewOptions) viewOptions)

Custom ReactViewInstances use this to create a host to connect to.



### PostToUIBatchingQueue
`static` void **`PostToUIBatchingQueue`**([`IReactContext`](IReactContext) context, [`ReactDispatcherCallback`](ReactDispatcherCallback) callback)

Post something to the main UI dispatcher using the batching queue



### SetUIBatchCompleteCallback
`static` void **`SetUIBatchCompleteCallback`**([`IReactPropertyBag`](IReactPropertyBag) properties, [`UIBatchCompleteCallback`](UIBatchCompleteCallback) xamlRoot)

Sets the Callback to call when a UI batch is completed. 




