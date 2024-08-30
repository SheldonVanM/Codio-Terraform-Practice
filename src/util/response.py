import json

class response:

    def __init__(self) -> None:
        pass

    def createResponse(self) -> dict:
        response = {
            "statusCode" : 200,
            "body" : json.dumps("Hello world")
            }
        return response