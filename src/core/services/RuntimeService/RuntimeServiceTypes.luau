export type Id = string
export type Callback = (deltaTime: number) -> ()
export type Priority = "First" | "High" | "Standard" | "Low" | "Last"
export type Score = number
export type Subscription = { id: Id, score: Score, callback: Callback }

export type SubscriptionArray = { [number]: Subscription }

export type ClientPipelines = "Update" | "Render"

return {}
