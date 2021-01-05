# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get :exec_sum, to: 'executive#index'
  get :financial, to: 'financial#index'
  get :high_level_breakdown_index, to: 'high_level_breakdown#index'

  resources :exchange
  get :product_weekly, to: 'product#weekly'
  get :product_daily, to: 'product#daily'
end
