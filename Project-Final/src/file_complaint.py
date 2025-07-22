from database import get_db_connection
import pymysql

def prompt_for_location():
    print("\n--- Enter Location ---")
    building_number = input("Enter building number (optional, press Enter to skip): ").strip() or None

    street = ""
    while not street:
        street = input("Enter street (required): ").strip()
        if not street:
            print("Street is required.")

    zipcode = ""
    while not zipcode:
        zipcode = input("Enter zipcode (required): ").strip()
        if not zipcode:
            print("Zipcode is required.")

    valid_boroughs = ["Manhattan", "Brooklyn", "Queens", "Bronx", "Staten Island"]
    borough = ""
    while borough not in valid_boroughs:
        borough = input("Enter borough (Manhattan, Brooklyn, Queens, Bronx, Staten Island): ").strip()
        if borough not in valid_boroughs:
            print("Invalid borough! Choose from:", ", ".join(valid_boroughs))

    conn = get_db_connection()
    if not conn:
        return None
    try:
        cursor = conn.cursor()
        sql = (
            "INSERT INTO incident_location (building_number, street, zipcode, borough_name)"
            " VALUES (%s, %s, %s, %s)"
        )
        cursor.execute(sql, (building_number, street, zipcode, borough))
        conn.commit()
        loc_id = cursor.lastrowid
        print(f"Location saved with ID: {loc_id}")
        return loc_id
    except Exception as e:
        print("Error creating location:", e)
        return None
    finally:
        cursor.close()
        conn.close()

def add_evidence(incident_id):
    conn = get_db_connection()
    if not conn:
        return
    try:
        cursor = conn.cursor()
        print("\n--- Add Evidence ---")
        evidence_type = input("Enter evidence type (e.g., Photo, Video, Document): ").strip()
        description = input("Enter evidence description: ").strip()
        storage_location = input("Enter storage location: ").strip()

        sql = (
            "INSERT INTO evidence (evidence_type, description, storage_location, incident_id)"
            " VALUES (%s, %s, %s, %s)"
        )
        cursor.execute(sql, (evidence_type, description, storage_location, incident_id))
        conn.commit()
        print("Evidence added successfully.")
    except Exception as e:
        print("Error adding evidence:", e)
    finally:
        cursor.close()
        conn.close()

def add_incident_involved_person(incident_id):
    conn = get_db_connection()
    if not conn:
        return None
    try:
        cursor = conn.cursor()
        print("\n--- Add General Involved Person ---")
        id_type = input("Enter ID type (e.g., Passport, Driver License): ").strip()
        id_number = input("Enter ID number: ").strip()
        first = input("First name: ").strip()
        last = input("Last name: ").strip()
        dob = input("Date of birth (YYYY-MM-DD): ").strip()
        gender = input("Gender: ").strip()
        address = input("Address: ").strip()
        phone = input("Phone number: ").strip()
        email = input("Email: ").strip()

        sql1 = (
            "INSERT INTO involved_person (id_type, id_number, first_name, last_name, date_of_birth, gender, address, phone_number, email)"
            " VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        )
        cursor.execute(sql1, (id_type, id_number, first, last, dob, gender, address, phone, email))
        conn.commit()
        person_id = cursor.lastrowid

        sql2 = (
            "INSERT INTO incident_involved_person (incident_id, involved_person_id)"
            " VALUES (%s, %s)"
        )
        cursor.execute(sql2, (incident_id, person_id))
        conn.commit()
        return person_id
    except Exception as e:
        print("Error adding involved person:", e)
        return None
    finally:
        cursor.close()
        conn.close()

def add_witness(incident_id):
    pid = add_incident_involved_person(incident_id)
    if not pid:
        return
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        print("\n--- Add Witness ---")
        statement = input("Enter witness statement: ").strip()
        stmt_time = input("Statement time (YYYY-MM-DD HH:MM:SS): ").strip()
        contact = input("Contact preference: ").strip()

        sql = (
            "INSERT INTO witness (involved_person_id, incident_id, witness_statement, statement_time, contact_preference)"
            " VALUES (%s, %s, %s, %s, %s)"
        )
        cursor.execute(sql, (pid, incident_id, statement, stmt_time, contact))
        conn.commit()
        print("Witness record added.")
    except Exception as e:
        print("Error adding witness:", e)
    finally:
        cursor.close()
        conn.close()

def add_person_of_interest(incident_id):
    pid = add_incident_involved_person(incident_id)
    if not pid:
        return
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        print("\n--- Add Person of Interest ---")
        reason = input("Reason for interest: ").strip()
        status = input("Investigation status: ").strip()
        identified = input("Date identified (YYYY-MM-DD): ").strip()

        sql = (
            "INSERT INTO person_of_interest (involved_person_id, incident_id, reason_for_interest, investigation_status, date_identified)"
            " VALUES (%s, %s, %s, %s, %s)"
        )
        cursor.execute(sql, (pid, incident_id, reason, status, identified))
        conn.commit()
        print("Person of interest added.")
    except Exception as e:
        print("Error adding person of interest:", e)
    finally:
        cursor.close()
        conn.close()

def add_victim(incident_id):
    pid = add_incident_involved_person(incident_id)
    if not pid:
        return
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        print("\n--- Add Victim ---")
        injury = input("Injury description: ").strip()
        statement = input("Victim statement: ").strip()

        sql = (
            "INSERT INTO victim (involved_person_id, incident_id, injury_description, victim_statement)"
            " VALUES (%s, %s, %s, %s)"
        )
        cursor.execute(sql, (pid, incident_id, injury, statement))
        conn.commit()
        print("Victim record added.")
    except Exception as e:
        print("Error adding victim:", e)
    finally:
        cursor.close()
        conn.close()

def add_involved_people(incident_id):
    while True:
        print("\n--- Add Involved People Menu ---")
        print("1. Add Victim")
        print("2. Add Person of Interest")
        print("3. Add Witness")
        print("4. Done")
        choice = input("Enter your choice: ").strip()
        if choice == '1':
            add_victim(incident_id)
        elif choice == '2':
            add_person_of_interest(incident_id)
        elif choice == '3':
            add_witness(incident_id)
        elif choice == '4':
            break
        else:
            print("Invalid choice. Please select 1-4.")

def file_complaint():
    conn = get_db_connection()
    if not conn:
        return
    try:
        cursor = conn.cursor()
        print("\n--- File a Complaint ---")
        date_str = input("Enter Incident Date (YYYY-MM-DD): ").strip()
        time_str = input("Enter Incident Time (HH:MM:SS): ").strip()
        description = input("Enter complaint description: ").strip()

        # Prompt for valid is_active enum
        valid_status = ['unresolved', 'in progress', 'resolved']
        status = ''
        while status not in valid_status:
            status = input(
                "Enter complaint status (unresolved, in progress, resolved): "
            ).strip().lower()
            if status not in valid_status:
                print("Invalid status. Choose from:", ", ".join(valid_status))

        # Enter location
        location_id = prompt_for_location()
        if not location_id:
            print("Failed to create location. Complaint not filed.")
            return

        # Insert new incident record
        insert_sql = (
            "INSERT INTO incident (incident_date, incident_time, is_active, description, location_id)"
            " VALUES (%s, %s, %s, %s, %s)"
        )
        cursor.execute(insert_sql, (date_str, time_str, status, description, location_id))
        conn.commit()

        # Fetch generated incident_id
        select_sql = """
            SELECT incident_id
            FROM incident
            WHERE
                incident_date   = %s AND
                incident_time   = %s AND
                is_active       = %s AND
                description     = %s AND
                location_id     = %s
            ORDER BY incident_id DESC
            LIMIT 1
        """
        cursor.execute(select_sql, (date_str, time_str, status, description, location_id))
        row = cursor.fetchone()
        if row:
            new_incident = row[0]
            print(f"Complaint filed successfully. Generated Incident ID: {new_incident}")

        # Attach evidence?
        if input("Do you want to attach evidence now? (y/n): ").strip().lower() == 'y':
            add_evidence(new_incident)

        # Add involved people?
        if input("Do you want to add involved people now? (y/n): ").strip().lower() == 'y':
            add_involved_people(new_incident)
    except Exception as e:
        print("Error filing complaint:", e)
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    file_complaint()
