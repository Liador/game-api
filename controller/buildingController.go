package controller

import (
    "net/http"
    "github.com/gorilla/context"
    "github.com/gorilla/mux"
    "kalaxia-game-api/exception"
    "kalaxia-game-api/manager"
    "kalaxia-game-api/model"
    "kalaxia-game-api/utils"
    "strconv"
)

func CreateBuilding(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    player := context.Get(r, "player").(*model.Player)

    id, _ := strconv.ParseUint(vars["id"], 10, 16)
    planet := manager.GetPlanet(uint16(id), player.Id)

    if uint16(id) != planet.Id {
        panic(exception.NewHttpException(403, "Forbidden", nil))
    }
    data := utils.DecodeJsonRequest(r)
    building, err := manager.CreateBuilding(planet, data["name"].(string))
    if err == nil {
        utils.SendJsonResponse(w, 201, building)
    }

}
