# views.py
import json
from pymongo import MongoClient
from rest_framework.views import APIView
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework.response import Response
from .mongo_client import PatientCollection
from bson import ObjectId
from datetime import datetime
from django.utils.decorators import method_decorator
from rest_framework import status
from django.views.decorators.csrf import ensure_csrf_cookie

@ensure_csrf_cookie
def get_csrf_token(request):
    return JsonResponse({'message': 'CSRF cookie set'})

def get_all_patients(request):
    patient_collection = PatientCollection()
    patients = patient_collection.get_all_patients()
    return JsonResponse({'patients': patients})

def get_active_patients(request, id_check):
    patient_collection = PatientCollection()
    patients = patient_collection.get_all_patients()

def get_patient_by_id(request, id):
    patient_collection = PatientCollection()
    patient = patient_collection.get_patient_by_id(id)
    if patient:
        return JsonResponse({'patient': patient})
    return JsonResponse({'error': 'Patient not found'}, status=404)

@csrf_exempt
@require_http_methods(["POST"])
def activating_patient(request):
    client = MongoClient("mongodb://localhost:27017")
    db = client["healthconnect"]
    patients_collection = db["patients"]

    try:
        # Parse JSON data from request body
        data = json.loads(request.body.decode("utf-8"))
        id_number = data.get("id_number")
        isActive = data.get("isActive")

        if not id_number or isActive is None:
            return JsonResponse({'error': 'id_number and isActive are required fields'}, status=400)

        # Check if user exists with matching credentials
        user = patients_collection.find_one({"id_number": id_number})

        if user:
            # Validate isActive value
            if isActive not in [0, 1]:
                return JsonResponse({'error': 'isActive must be 0 or 1'}, status=400)

            # Update the user's isActive status
            patients_collection.update_one(
                {"id_number": id_number},
                {"$set": {"isActive": True if isActive == 1 else False}},
            )
            return JsonResponse({'message': 'User status updated successfully'}, status=200)
        else:
            return JsonResponse({'error': 'User not found'}, status=404)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
#################################################
# @csrf_exempt
# @require_http_methods(["POST"])
# def checkingRequests(request):
#     client = MongoClient("mongodb://localhost:27017")
#     db = client["healthconnect"]
#     patients_collection = db["patients"]

#     try:
#         data = json.loads(request.body.decode("utf-8"))
#         id_number = data.get("id_number"),
#         new_status = data.get("status"),

#         if not id_number or not new_status:
#             return Response({"error": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

#         if new_status not in ["pending", "active", "inactive"]:
#             return Response({"error": "Invalid status value"}, status=status.HTTP_400_BAD_REQUEST)
        
#         # Find and update the latest session for this patient
#         result = patients_collection.find_one_and_update(
#             {"id_number": id_number},
#             {"$set": {"status": new_status, "updated_at": datetime.utcnow()}},
#             sort=[("_id", -1)],
#             return_document=True
#         )
        
#         if not result:
#             return Response({"error": "Session not found"}, status=status.HTTP_404_NOT_FOUND)

#         return Response({
#             "message": f"Status updated to {new_status}",
#             "session": {
#                 "id": str(result["_id"]),
#                 "status": result["status"],
#                 "updated_at": result["updated_at"]
#             }
#         }, status=status.HTTP_200_OK)
#     except Exception as e:
#         return JsonResponse({'error': str(e)}, status=500)

#################################################

@method_decorator(csrf_exempt, name='dispatch')
class MyTestRequestView(APIView):
    def post(self, request, *args, **kwargs):
        data = request.data
        print(data)
        return Response({'message': 'Success', 'data': data})

@method_decorator(csrf_exempt, name='dispatch')
class UpdatePatientStatusView(APIView):
    def post(self, request, *args, **kwargs):
        data = request.data
        client = MongoClient("mongodb://localhost:27017")
        db = client["healthconnect"]
        patients_collection = db["patients"]

        patient_id = data.get("patient_id")
        new_status = data.get("status")
        print(new_status)
        print(patient_id)

        if not patient_id or not new_status:
            return Response({"error": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        if new_status not in ["pending", "active", "inactive"]:
            return Response({"error": "Invalid status value"}, status=status.HTTP_400_BAD_REQUEST)
        
        found_user = patients_collection.find_one({"id_number": patient_id})

        if found_user:
            result = patients_collection.find_one_and_update(
                {"id_number": patient_id},
                {"$set": {"status": new_status, "updated_at": datetime.utcnow()}},
            )

        if result:
            return JsonResponse({
                "message": "Status updated successfully",
                "new_status": result.get("status"),
                "updated_at": result.get("updated_at").isoformat() if result.get("updated_at") else None
            })
        else:
            return JsonResponse({"error": "Update failed"}, status=500)
        
        # Find and update the latest session for this patient
        # result = patients_collection.find_one_and_update(
        #     {"id_number": patient_id},
        #     {"$set": {"status": new_status, "updated_at": datetime.utcnow()}},
        #     sort=[("_id", -1)],
        #     return_document=True
        # )

        # if not result:
        #     return Response({"error": "Session not found"}, status=status.HTTP_404_NOT_FOUND)

        # print("UpdatePatientStatusView:", data)
        # return Response({'message': 'Patient status updated', 'data': data})

        # try:
        #     print("Parsed data:", request.data)
        # except Exception as e:
        #     print("Failed to parse request.data:", e)
        
        # client = MongoClient("mongodb://localhost:27017")
        # db = client["healthconnect"]
        # patients_collection = db["patients"]

        # data = json.loads(request.body.decode("utf-8"))

        # patient_id = data.get("patient_id")
        # new_status = data.get("status")
        # print(new_status)

        # if not patient_id or not new_status:
        #     return Response({"error": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        # if new_status not in ["pending", "active", "inactive"]:
        #     return Response({"error": "Invalid status value"}, status=status.HTTP_400_BAD_REQUEST)

        # # Find and update the latest session for this patient
        # result = patients_collection.find_one_and_update(
        #     {"id_number": patient_id},
        #     {"$set": {"status": new_status, "updated_at": datetime.utcnow()}},
        #     sort=[("_id", -1)],
        #     return_document=True
        # )

        # if not result:
        #     return Response({"error": "Session not found"}, status=status.HTTP_404_NOT_FOUND)

        # return Response({
        #     "message": f"Status updated to {new_status}",
        #     "session": {
        #         "id": str(result["_id"]),
        #         "status": result["status"],
        #         "updated_at": result["updated_at"]
        #     }
        # }, status=status.HTTP_200_OK)