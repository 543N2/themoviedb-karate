Feature: API GET test

  Background:
    * url 'https://api.themoviedb.org/3'

    Scenario: Request Token
      Given path '/authentication/token/new'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      When method GET
      Then status 200

    Scenario: Create Session with Login
      Given path '/authentication/token/validate_with_login'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      And request {"username": "543n2","password": "543n2Movies","request_token": "82a7b21132d3fd183533f2aac94891ae5200276d"}
      When method POST
      Then status 200

    Scenario: Unsuccessful Session creation by wrong password
      Given path '/authentication/token/validate_with_login'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      And request {"username": "543n2","password": "fakepassword","request_token": "69c843fdede3e43f98f7dd8c593b00753945f1b4"}
      When method POST
      Then status 401

    Scenario: Create Session
      Given path '/authentication/session/new'
      And request {"request_token": "82a7b21132d3fd183533f2aac94891ae5200276d"}
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      When method POST
      Then status 200

    Scenario: Get popular movies
      Given path '/movie/popular'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      When method GET
      Then status 200

    Scenario: Create List
      Given path '/list'
      And header Content-Type = 'application/json;charset=utf-8'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      And param session_id = 'a12c9c8a9e54443298204fb3d4277ddfc004b7bc'
      And request {"name": "Karate made list :)","description": "This is my Karate made list.","language": "en"}
      When method POST
      Then status 201


    Scenario Outline: Delete List
      Given path '/list/<list_id>'
      And param api_key = '0383f0931f7f6bb14fe64530a706ce6c'
      And param session_id = 'a12c9c8a9e54443298204fb3d4277ddfc004b7bc'
      When method POST
      Then status 200
      Examples:
      |list_id|
      |8193411|
