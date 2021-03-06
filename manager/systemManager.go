package manager

import(
    "kalaxia-game-api/database"
    "kalaxia-game-api/exception"
    "kalaxia-game-api/model"
)

func GetMapSystems(mapId uint16) []model.System {
    var systems []model.System
    if err := database.Connection.Model(&systems).Where("map_id = ?", mapId).Select(); err != nil {
        panic(exception.NewHttpException(404, "Map not found", err))
    }
    return systems
}

func GetSystem(id uint16) *model.System {
    system := model.System{Id: id}
    if err := database.Connection.Select(&system); err != nil {
        return nil
    }
    system.Planets = GetSystemPlanets(id)
    return &system
}
