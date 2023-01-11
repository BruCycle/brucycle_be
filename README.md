# README

## Table of Contents
* [General Info](#general-info)
* [Learning Goals](#learning-goals)
* [Technologies](#technologies)
* [Usage](#usage)
* [API Endpoints](#api-endpoints)
  * [Strava User Endpoints](#strava-user-endpoints)
  * [Strava Activity Endpoint](#strava-activity-endpoint)

## General Info
ReadMe for Both FE and BE (https://github.com/BruCycle/readme)<br>
Rails Engine is a basic RESTful API that provides information about users ([endpoints](#api-endpoints)). We were to work in a service-oriented architecture by first exposing the data through this API.

## Learning Goals
- Consume two or more external APIs
- Create a project with a separate frontend and backend
- Code follows DRY and SRP design

## Technologies
- Ruby 2.7.4
- Rails 5.2.8

## Usage

Clone the repo by running `git clone` with the copied URL onto your local machine

Then, run the following commands:
```
cd rails-engine
bundle install
rails db:{drop,create,migrate,seed}
rails s
```

Lastly, head to your web browser or Postman. The base URL is `localhost:3000` and endpoints are listed below.

## API Endpoints

### Strava User Endpoints
- ### GET /api/v1/user
  > fetch a user
  
  | Path Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | strava_uid      | string | Required |
  | strava_token      | string | Required |
  
  Example:
  ```
  {"data"=> { 
  "id"=>"390",
  "type"=>"user", 
  "attributes"=> { 
    "brubank"=>674.81,
    "beers_drunk"=>59.58, 
    "tot_gas_money_saved"=>22.43, 
    "tot_calories_burned"=>8.558, 
    "tot_miles_biked"=>0.171 
    } 
    } 
  }
  ```
<br> 

- ### PATCH /api/v1/user
  > delete a beer from user's Brübank
  
  | Path Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | strava_uid      | string | Required |

  Required query params:
    {drank: 'beer'}  

  Example:
  
  ```
  {"data"=> { 
    "id"=>"390",
    "type"=>"user", 
    "attributes"=> { 
      "brubank"=>674.81,
      "beers_drunk"=>59.58, 
      "tot_gas_money_saved"=>22.43, 
      "tot_calories_burned"=>8.558, 
      "tot_miles_biked"=>0.171 
    } 
    } 
  }
  ```
  <br>

### Strava Activity Endpoint
- ### GET /api/v1/activity
  > fetch a user's activities
  
  | Path Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | strava_uid      | string | Required |
  | strava_token      | string | Required |


  Example:
  
  ```
   {"data"=> 
     [{"id"=>"1803",
      "type"=>"activity", 
      "attributes"=>{"date"=>"2021-09-26T13:57:52.000Z", 
      "title"=>"Morning Ride",
      "calories_burned"=>266.984, 
      "gas_money_saved"=>0.0022, 
      "beers_banked"=>0.04, 
      "miles"=>5.3396875}},
     {"id"=>"1802", 
      "type"=>"activity", 
      "attributes"=> 
       {"date"=>"2021-12-07T04:03:43.000Z", 
        "title"=>"20 min Caribbean Holiday Ride with Ally Love", 
        "calories_burned"=>251.963, 
        "gas_money_saved"=>0.0015, 
        "beers_banked"=>0.02, 
        "miles"=>5.03925}}]
        }
    ```
