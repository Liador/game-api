package manager

import(
    "kalaxia-game-api/database"
    "kalaxia-game-api/exception"
    "kalaxia-game-api/model"
)

func GetServerBySignature(signature string) *model.Server {
    server := model.Server{Signature: signature}
    if err := database.Connection.Model(&server).Where("signature = ?", signature).Select(); err != nil {
        panic(exception.NewHttpException(404, "Server could not be found", err))
    }
    return &server
}

func CreateServer(name string, serverType string, signature string) *model.Server {
    server := &model.Server{
        Name: name,
        Type: serverType,
        Signature: signature,
    }
    if err := database.Connection.Insert(server); err != nil {
        panic(exception.NewHttpException(500, "Server could not be created", err))
    }
    return server
}
