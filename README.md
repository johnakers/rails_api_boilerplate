# Rails API Boilerplate

Just a little Rails API so I don't need the same setup for new Rails apps.

```
root GET    /                    things#index

GET    /things                   things#index
POST   /things                   things#create
GET    /things/:id               things#show
PATCH  /things/:id               things#update
PUT    /things/:id               things#update
DELETE /things/:id               things#destroy
```
