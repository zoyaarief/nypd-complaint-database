from database import get_db_connection
import pymysql

#Checking if incident exists
def incident_exists(incident_id): 
    conn = get_db_connection()
    if not conn:
        return False
    try:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT 1 FROM incident WHERE incident_id = %s LIMIT 1", 
            (incident_id,)
        )
        result = cursor.fetchone()
        return result is not None
    finally:
        cursor.close()
        conn.close()

#Error check - prompt until a valid incident ID is provided
def manage_evidences():
    incident_id = input("Enter Incident ID to manage evidence: ").strip()
    while not incident_exists(incident_id):
        print(f"Incident ID '{incident_id}' not found. Please enter a valid Incident ID.")
        incident_id = input("Enter Incident ID to manage evidence: ").strip()

    while True:
        print("\n--- Manage Evidence Menu ---")
        print("1. Add Evidence")
        print("2. View Evidence for Incident")
        print("3. Return to Main Menu")
        choice = input("Enter your choice: ").strip()
        if choice == '1':
            add_evidence(incident_id)
        elif choice == '2':
            view_evidence(incident_id)
        elif choice == '3':
            break
        else:
            print("Invalid choice. Please enter 1, 2, or 3.")


def add_evidence(incident_id):
    conn = get_db_connection()
    if not conn:
        return
    cursor = conn.cursor()
    try:
        print("\n--- Add Evidence ---")
        #Validate non-empty inputs
        while True:
            evidence_type = input("Enter Evidence Type (e.g., Photo, Video, Document): ").strip()
            if evidence_type:
                break
            print("Evidence Type cannot be blank.")

        while True:
            description = input("Enter Evidence Description: ").strip()
            if description:
                break
            print("Description cannot be blank.")

        while True:
            storage = input("Enter Storage Location: ").strip()
            if storage:
                break
            print("Storage Location cannot be blank.")

        #Insert validated evidence
        query = (
            "INSERT INTO evidence (evidence_type, description, storage_location, incident_id)"
            " VALUES (%s, %s, %s, %s)"
        )
        cursor.execute(query, (evidence_type, description, storage, incident_id))
        conn.commit()
        print("Evidence added successfully.")
    except Exception as e:
        print("Error adding evidence:", e)
    finally:
        cursor.close()
        conn.close()


def view_evidence(incident_id):
    conn = get_db_connection()
    if not conn:
        return
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    try:
        query = (
            "SELECT evidence_id, evidence_type, description, storage_location "
            "FROM evidence WHERE incident_id = %s"
        )
        cursor.execute(query, (incident_id,))
        rows = cursor.fetchall()

        if rows:
            print(f"\nEvidence for Incident {incident_id}:")
            for row in rows:
                print(
                    f"ID: {row['evidence_id']}, "
                    f"Type: {row['evidence_type']}, "
                    f"Desc: {row['description']}, "
                    f"Storage: {row['storage_location']}"
                )
        else:
            print("No evidence found for this incident.")
    except Exception as e:
        print("Error retrieving evidence:", e)
    finally:
        cursor.close()
        conn.close()
