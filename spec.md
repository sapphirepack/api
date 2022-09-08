``` code
/api/20220720/new
```

Creates a new operator

```json
{
  "handle": "<string handle>",
  "server_key": "<string base64 encoded 256 bit key>"
}
```

Response:

200 -> Success
422 -> Missing a field or improper field

---

``` code
/api/20220720/connect
```

Connect and retrieve access and refresh tokens.

```json
{
  "handle": "<string handle>",
  "server_key": "<string base64 encoded 256 bit key>"
}
```

Response:

Returns either 200 and 
``` json
{
  "access_token": "<string base64 encoded 256 bits>",
  "refresh_token": "<string base64 encoded 512 bits>"
}
```

Access token is valid for 1 hour and refresh token valid for 30 days.

Or returns 404

---

``` code
/api/20220720/profile
```

Must include in the JSON object 
``` json
{
  "access_token": "<string base64 encoded 256 bits>"
}
```

Response:

Returns 200 + arbitrary json, for version 1 is 

``` json
{
  "message":"<string message>"
}
```

Or 
Returns 401
  If this is the case then do
  
 ``` code
 /api/20220720/refresh
```

``` json
{
  "refresh_token" : "string base64 512 bit refresh token"
}
```

Which will return either 200 and

``` json
{
  "access_token": "<string base64 encoded 256 bits>",
  "refresh_token": "<string base64 encoded 512 bits>"
}
```

or returns 401. 
