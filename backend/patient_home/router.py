from django.urls import path
from . import views

urlpatterns = [
    path('get-csrf/', views.get_csrf_token, name='get cookies'),
    path('patients/', views.get_all_patients, name='all_patients'),
    path('patient/<str:id>/', views.get_patient_by_id, name='patient_detail'),
    path('active/', views.activating_patient, name='toggle_is_active'),
    path('test/', views.MyTestRequestView.as_view()),
    path('request/', views.UpdatePatientStatusView.as_view(), name='request'),
]