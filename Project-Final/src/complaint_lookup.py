import pymysql
from database import get_db_connection
from file_complaint import add_involved_people  # Import for adding involved people


def show_all_incidents():
    conn = get_db_connection()
    if not conn:
        return
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    query = (
        "SELECT incident_id, incident_date, incident_time, is_active, description, location_id "
        "FROM incident"
    )
    cursor.execute(query)
    rows = cursor.fetchall()
    print("\n--- All Incidents ---")
    for r in rows:
        print(
            f"ID: {r['incident_id']} | Date: {r['incident_date']} | "
            f"Time: {r['incident_time']} | Status: {r['is_active']} | Desc: {r['description']}"
        )
    cursor.close()
    conn.close()


def show_incident_details():
    incident_id = input("Enter Incident ID: ").strip()
    conn = get_db_connection()
    if not conn:
        return None
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    query = "SELECT * FROM incident WHERE incident_id = %s"
    cursor.execute(query, (incident_id,))
    incident = cursor.fetchone()
    if incident:
        print("\n--- Incident Details ---")
        for key, val in incident.items():
            print(f"{key}: {val}")
        cursor.close()
        conn.close()
        return incident_id
    else:
        print("Incident not found.")
        cursor.close()
        conn.close()
        return None


def update_incident(incident_id):
    conn = get_db_connection()
    if not conn:
        return
    try:
        cursor = conn.cursor()
        while True:
            print("\n--- Update Incident ---")
            print("1. Date")
            print("2. Time")
            print("3. Status")
            print("4. Description")
            print("5. Add Involved People")
            print("6. Done")
            choice = input("Enter your choice: ").strip()
            if choice == '1':
                new_val = input("Enter new date (YYYY-MM-DD): ").strip()
                field = 'incident_date'
            elif choice == '2':
                new_val = input("Enter new time (HH:MM:SS): ").strip()
                field = 'incident_time'
            elif choice == '3':
                valid_status = ['unresolved', 'in progress', 'resolved']
                status = ''
                while status not in valid_status:
                    status = input(
                        "Enter new status (unresolved, in progress, resolved): "
                    ).strip().lower()
                    if status not in valid_status:
                        print("Invalid status. Choose from:", ", ".join(valid_status))
                new_val = status
                field = 'is_active'
            elif choice == '4':
                new_val = input("Enter new description: ").strip()
                field = 'description'
            elif choice == '5':
                # Launch involved people submenu
                add_involved_people(incident_id)
                continue
            elif choice == '6':
                break
            else:
                print("Invalid choice.")
                continue

            # Perform the update
            sql = f"UPDATE incident SET {field} = %s WHERE incident_id = %s"
            cursor.execute(sql, (new_val, incident_id))
            conn.commit()
            print(f"{field} updated successfully.")

        print("Updates complete.")
    except Exception as e:
        print("Error updating incident:", e)
    finally:
        cursor.close()
        conn.close()


def complaint_lookup_menu():
    while True:
        print("\n--- Complaint Lookup Menu ---")
        print("1. See All Incidents")
        print("2. Lookup Incident by ID")
        print("3. Return to Main Menu")
        choice = input("Enter your choice: ").strip()
        if choice == '1':
            show_all_incidents()
        elif choice == '2':
            incident_id = show_incident_details()
            if incident_id:
                if input("Do you want to update this incident? (y/n): ").strip().lower() == 'y':
                    update_incident(incident_id)
        elif choice == '3':
            break
        else:
            print("Invalid choice.")
