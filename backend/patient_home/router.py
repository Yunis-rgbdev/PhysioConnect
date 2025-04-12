from django.urls import path
from . import views

urlpatterns = [
    path('patients/', views.get_all_patients, name='all_patients'),
    path('patient/<str:id>/', views.get_patient_by_id, name='patient_detail'),
    path('active/', views.activating_patient, name='toggle_is_active'),
]