from django.http import JsonResponse, HttpResponse
import hashlib
from pymongo import MongoClient
import json
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods

# Create your views here.
def welcome(request):
    return HttpResponse('Welcome to Django')

client = MongoClient("mongodb://localhost:27017")
db = client["healthconnect"]
patients_collection = db["patients"]

def hash_password(password: str) -> str:
    """Hashes the password using SHA-256."""
    return hashlib.sha256(password.encode()).hexdigest()

@csrf_exempt
def register_user(request):
    """Handles user registration from a JSON request."""
    if request.method != "POST":
        return JsonResponse({"success": False, "message": "Only POST requests are allowed"}, status=405),
    

    try:
        # Parse JSON data from Flutter
        data = json.loads(request.body.decode("utf-8"))
        id_number = data.get("id_number")
        password = data.get("password")
        name = data.get("name")
        age = data.get("age")
        phone_number = data.get("phone_number")
        gender = data.get("gender")
        extra_info = data.get("extra_info")
        print(phone_number)

        # Validate required fields
        if not id_number or not password:
            return JsonResponse({"success": False, "message": "ID and Password are required"}, status=400)

        # Check if user already exists
        if patients_collection.find_one({"id_number": id_number}):
            return JsonResponse({"success": False, "message": "User already exists"}, status=400)

        # Hash password
        # hashed_password = hash_password(password)

        # Save user
        user_data = {
            "id_number": id_number,
            "password": password,
            "name": name,
            "age": age,
            "gender": gender,
            "phone_number": phone_number,
            "extra_info": extra_info,
            "isActive": False,
        }

        # Save user data in mongoDB
        patients_collection.insert_one(user_data)

        return JsonResponse({"success": True, "message": "User registered successfully"}, status=201)

    except json.JSONDecodeError:
        return JsonResponse({"success": False, "message": "Invalid JSON data"}, status=400)


@csrf_exempt
@require_http_methods(["POST"])
def login(request):
    try:
        # Parse JSON data from request body
        data = json.loads(request.body.decode("utf-8"))
        id_number = data.get("id_number")
        password = data.get("password")

        # Validate input
        if not id_number or not password:
            return JsonResponse({
                "success": False, 
                "message": "ID and Password are required"
            }, status=400)

        # Hash the password
        # hashed_password = hash_password(password)
        # print(hashed_password)

        # Check if user exists with matching credentials
        user = patients_collection.find_one({
            "id_number": id_number, 
            "password": password
        })

        if user:
            return JsonResponse({
                "success": True, 
                "message": "User logged in successfully",
                "user_data": {
                    "id_number": user["id_number"],
                    "name": user.get("name"),
                    # Add other safe user info to return
                }
            }, status=200)
        else:
            return JsonResponse({
                "success": False, 
                "message": "Invalid credentials"
            }, status=401)

    except json.JSONDecodeError:
        return JsonResponse({
            "success": False, 
            "message": "Invalid JSON data"
        }, status=400)
    except Exception as e:
        return JsonResponse({
            "success": False, 
            "message": str(e)
        }, status=500)
    
    ##
    # hello commit

    ## new commit from sina test