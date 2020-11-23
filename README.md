# GlossGenius`s take-home technical challenge for backend developers

## [Task description](https://www.notion.so/Backend-Developer-Take-Home-Technical-Challenge-d0acf3300626432d8b78dbb4c0ce60a0)

## Requirements
```
ruby 2.7
postgresql
```

## Setup
```
git clone https://github.com/b0nn1e/gg_test.git
cd gg_test
bundle install
 
cp config/database.example.yml config/database.yml
cp config/master.key.development config/master.key

bundle exec rake db:create
bundle exec rake db:migrate
```

Edit credentials for MailGun and SendGrid services using command `EDITOR="nano" rails credentials:edit`

## Start server
```
rails s
```

## Run tests
```
bundle exec rspec
```

## API endpoints

### Create campaigns
#### Request
```
POST /api/campaigns

Authorization: "Bearer 8d4aa039dde3f9cf90dc68e0d32b6f90"
Content-Type: "application/json"

{
  "campaign": {
    "subject": "Subject",
    "message": "Message",
    "emails": [
      "test1@gmail.com",
      "test2@gmail.com"
    ]
  }
}
```
#### Success response
```
Status: 201 Created

""
```

#### Validation errors
```
Status: 422 unprocessable_entity

{"errors":{"subject":["can't be blank"]}}
```

See more details [spec/requests/api/create_campaings_spec.rb](https://github.com/b0nn1e/gg_test/blob/features/spec/requests/api/create_campaings_spec.rb)

### Show customers list
#### Request
```
GET /api/customers

Authorization: "Bearer 8d4aa039dde3f9cf90dc68e0d32b6f90"
Content-Type: "application/json"
```
#### Success response
```
Status: 200

[
  {
    "id": 3262,
    "email": "customer4@gmail.com",
    "campaigns_count": 2
  },
  {
    "id": 3263,
    "email": "customer5@gmail.com",
    "campaigns_count": 1
  },
  {
    "id": 3264,
    "email": "customer6@gmail.com",
    "campaigns_count": 1
  }
]
```
See more details [spec/requests/api/show_customers_list_spec.rb](https://github.com/b0nn1e/gg_test/blob/features/spec/requests/api/show_customers_list_spec.rb)

### Show customer’s campaigns
#### Request
```
GET /api/customers/:id

Authorization: "Bearer 8d4aa039dde3f9cf90dc68e0d32b6f90"
Content-Type: "application/json"
```
#### Success response
```
Status: 200

{
  "id": 123,
  "email": "customer2@gmail.com",
  "campaigns": [
    {
      "id": 1225,
      "subject": "subject 1",
      "created_at": "2020-11-23 10:23:12 UTC"
    },
    {
      "id": 1226,
      "subject": "subject 2",
      "created_at": "2020-11-24 11:55:17 UTC"
    },
    {
      "id": 1227,
      "subject": "subject 3",
      "created_at": "2020-11-24 15:23:46 UTC"
    }
  ]
}
```

See more details [spec/requests/api/show_customer_item_spec.rb](https://github.com/b0nn1e/gg_test/blob/features/spec/requests/api/show_customer_item_spec.rb)
