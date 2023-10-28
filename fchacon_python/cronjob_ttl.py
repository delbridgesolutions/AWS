import pymongo
import os
from dotenv import load_dotenv
from datetime import datetime


def remove_collection_if_exists(collections, collection_name):
    collections = [
        collection for collection in collections if collection != collection_name]
    return collections


dbBlocked = ["local", "admin"]

if __name__ == "__main__":

    try:

        load_dotenv()

        url_provider = os.getenv("MONGODB_URI_PROVIDER")
        url_target = os.getenv("MONGODB_URI_TARGET")
        documents_list = []
        if url_provider:
            client_provider = pymongo.MongoClient(url_provider)

            databases = client_provider.list_databases()

    # Filter out the blocked databases

            for database in databases:
                db_name = database["name"]
                db = client_provider.get_database(db_name)
                db_sizeOnDisk = database["sizeOnDisk"]
                collections = db.list_collection_names()
                collections = [collection for collection in collections if not collection.startswith(
                    'system.buckets')]
                collections = remove_collection_if_exists(collections, "stats")
                if database["name"] not in dbBlocked:
                    serverStatus = db.command("whatsmyuri")
                    #metrics = serverStatus["metrics"]
                    #documents_list.append()
                    print(serverStatus)
        else:
            print("MongoDB URI PROVIDER not found")
        if url_target:
            client_target = pymongo.MongoClient(url_target)
            databases_target = client_target.list_databases()
            databases_target = [
                db for db in databases_target if db["name"] not in dbBlocked]

            dbTimeSeries = client_target["stats_ts"]
            collectionTS = dbTimeSeries["ttl"]
            if not any(db.get("name") == "stats_ts" for db in databases_target):
                dbTimeSeries.create_collection(
                    "ttl", timeseries={'timeField': "timestamp", "metaField": "metadata"})
            # for document in documents_list:
                # collectionTS.insert_one(document)
                # print(document)
        else:
            print("MongoDB URI target not found in .env file.")
    except FileNotFoundError:
        print("The .env file was not found. Please create it with the required environment variables.")
