# Rojo Project Template
Rojo Project Template is your basic Rojo project, utilizing [genFeatureTree](https://github.com/leifstout/genFeatureTree) by leifstout to organize code to its respective places.

## Installation
Go to the main repo and press `Use this template -> Create new repository`. After loading your project up, install Rojo.

To install packages, run (assuming you have wally on your system):

```bash
wally install
```

## How To Use
**All client scripts are placed inside of ReplicatedStorage**
**Server scripts are mapped to ServerScriptService)

Run the task `Watch Rojo Tree` to start automatically updating your project with every change you make to a file.
genFeatureTree will automatically move files to where they are required to be in-game, so you can have every script in one folder for organization, and genFeatureTree will move them to their respective folders (server scripts -> ServerScriptService, client scripts and other -> ReplicatedStorage)

### Start Up
In `src/startup`, you can find the Server and Client init scripts, following a MountUI module that the client uses to mount `src/features/app` to. `src/features/app` includes the necessary files to control what is showing on screen.
- The init scripts call `:init()` on every single script that includes the keyword "Server" or "Client" inside either `src/core/services` or `src/features`.

### Services
In `src/core/services` **AND** `src/features`, you will find and can create services (folders) that include modules that control that service. They will include one Server script and one Client script, each of which will be moved to their respective folders when genFeatureTree is run (the task automatically does this whenever you update a file). Core services also include 3 custom-made services already, such as:
- DataService is a wrapper for leifstout's DataService.
- EventService is a simple networker that allows you to create events on the server and get them on both the server and client.
- RuntimeService lets the server and client subscribe to already initialized RunService loops; the client has 2 pipelines, such as "Update" and "Render".

### Features
In src/features, you will find and can create features (folders) that include modules ranging from controlling UI to the server/client.

### UI
Rojo Project Template uses Vide to code your UI, but this can be changed and would need some tinkering.
`src/core/ui` houses global ui components, hooks, and primitives. It also houses `Theme.luau`, able to be used as a global theme editor (if you want)
- Components are made of primitives, and hooks are easy-to-use functions; there are already a few preset primitives and hooks inside of `src/core/ui`.
- Features can house a ui folder that includes their own custom components, hooks, and primitives. (ex. `src/features/animal/ui` can include a component called `components/AnimalIcon.luau` that is used by `AnimalMenu.luau` to display your inventory of animals)

## Attributions
[genFeatureTree](https://github.com/leifstout/genFeatureTree) by leifstout
