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
            databases_provider = client_provider.list_databases()
            pipeline = [{"$collStats": {"storageStats": {"scale": 1024}}}]

    # Filter out the blocked databases

            for database in databases_provider:
                db_name = database["name"]
                db = client_provider.get_database(db_name)
                db_sizeOnDisk = database["sizeOnDisk"]
                collections = db.list_collection_names()
                collections = [collection for collection in collections if not collection.startswith(
                    'system.buckets')]
                collections = remove_collection_if_exists(collections, "stats")

                for collection in collections:
                    dataClient = client_provider[db_name]
                    colClient = dataClient[collection]

                    results = colClient.aggregate(pipeline)

                    for item in results:

                        total_docs = colClient.count_documents(filter={}) if "timeseries" in item[
                            "storageStats"] else item["storageStats"]["count"]
                        ns = item["ns"]
                        serverTime = item["localTime"]
                        utc_datetime = datetime.now()
                        print(serverTime, utc_datetime)
                        # datetime.strptime(serverTime,"%Y-%m-%dT%H:%M:%SZ")

                        # if "timeseries" in item["storageStats"] else item["storageStats"]["size"]
                        size = item["storageStats"]["size"]
                        storage_size = item["storageStats"]["storageSize"]
                        free_space = item["storageStats"]["freeStorageSize"]
                        total_size = item["storageStats"]["totalSize"]
                        totalIndex_size = item["storageStats"]["totalIndexSize"]
                        tsDocument = {"metadata": {"ns": ns, "bd": db_name, "collection": collection},
                                      "timestamp": serverTime, "size": size, "storage_size": storage_size, "free_storage_size": free_space, "total_size": total_size, "total_index_size": totalIndex_size, "total_docs": total_docs}
                        documents_list.append(tsDocument)
        else:
            print("MongoDB URI provider not found in .env file.")
        if url_target:
            client_target = pymongo.MongoClient(url_target)
            databases_target = client_target.list_databases()
            databases_target = [
                db for db in databases_target if db["name"] not in dbBlocked]

            dbTimeSeries = client_target["stats_ts"]
            collectionTS = dbTimeSeries["storage"]
            if not any(db.get("name") == "stats_ts" for db in databases_target):
                dbTimeSeries.create_collection(
                    "storage", timeseries={'timeField': "timestamp", "metaField": "metadata"})
            for document in documents_list:
                print('Inserting document: ${document}}')
                collectionTS.insert_one(document)
        else:
            print("MongoDB URI target not found in .env file.")
    except FileNotFoundError:
        print("The .env file was not found. Please create it with the required environment variables.")
