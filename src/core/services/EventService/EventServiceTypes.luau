export type EventType = "Reliable" | "Unreliable" | "Function"
export type EventClass = "RemoteEvent" | "UnreliableRemoteEvent" | "RemoteFunction"
export type Event = RemoteEvent | UnreliableRemoteEvent | RemoteFunction
export type EventClassMap = {
	Reliable: RemoteEvent,
	Unreliable: UnreliableRemoteEvent,
	Function: RemoteFunction,
}

export type Path = { string } | string

return {}
