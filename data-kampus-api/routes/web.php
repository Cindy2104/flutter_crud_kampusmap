<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->group(['prefix' => 'api'], function () use ($router) {
    $router->get('kampus', 'KampusController@index');
    $router->get('kampus/{id}', 'KampusController@show');
    $router->post('kampus', 'KampusController@store');
    $router->put('kampus/{id}', 'KampusController@update');
    $router->delete('kampus/{id}', 'KampusController@destroy');
});
