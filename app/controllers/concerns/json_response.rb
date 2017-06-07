module JSONResponse
    def json_response object, status_code = :ok
        render json: object, status: status_code
    end
end