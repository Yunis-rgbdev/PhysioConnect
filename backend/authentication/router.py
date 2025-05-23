from django.urls import path
from authentication import views

urlpatterns = [
    path('hello/', views.welcome),
    path('register/', views.register_user, name="register_user"),
    path('login/', views.login, name="login_user"),
]