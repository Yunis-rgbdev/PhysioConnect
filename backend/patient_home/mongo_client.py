# mongo_client.py
from pymongo import MongoClient
from django.conf import settings

class MongoDBConnection:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(MongoDBConnection, cls).__new__(cls)
            # Get MongoDB connection details from settings
            mongo_uri = settings.MONGO_URI
            cls._instance.client = MongoClient(mongo_uri)
            cls._instance.db = cls._instance.client[settings.MONGO_DB_NAME]
        return cls._instance

class PatientCollection:
    def __init__(self):
        connection = MongoDBConnection()
        self.collection = connection.db['patients']
    
    def get_all_patients(self):
        # Only return the name field
        patients = list(self.collection.find({}, {'_id': 0,}))
        return patients
    
    def get_patient_by_id(self, id):
        # Filter by name
        return self.collection.find_one({'id_number': id}, {'_id': 0})