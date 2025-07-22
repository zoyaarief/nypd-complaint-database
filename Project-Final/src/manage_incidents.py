from database import get_db_connection
import pymysql

def assign_incident(conn):
    emp = input("Employee ID: ").strip()
    inc = input("Incident ID: ").strip()
    with conn.cursor() as cursor:
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (emp,))
        if not cursor.fetchone():
            print(f"Error: Employee {emp} does not exist.")
            return
        cursor.execute("SELECT 1 FROM incident WHERE incident_id = %s", (inc,))
        if not cursor.fetchone():
            print(f"Error: Incident {inc} does not exist.")
            return
        try:
            cursor.execute(
                "INSERT INTO handling_incident (employee_id, incident_id) VALUES (%s, %s)",
                (emp, inc)
            )
            conn.commit()
            print("Incident assigned.")
        except pymysql.err.IntegrityError as e:
            print(f"Assignment error (possibly duplicate): {e}")

def update_assignment(conn):
    emp = input("Current Employee ID: ").strip()
    inc = input("Incident ID: ").strip()
    new_emp = input("New Employee ID: ").strip()
    with conn.cursor() as cursor:
        cursor.execute(
            "SELECT 1 FROM handling_incident WHERE employee_id = %s AND incident_id = %s",
            (emp, inc)
        )
        if not cursor.fetchone():
            print("Error: No such assignment to update.")
            return
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (new_emp,))
        if not cursor.fetchone():
            print(f"Error: New employee {new_emp} does not exist.")
            return
        cursor.execute(
            "UPDATE handling_incident "
            "SET employee_id = %s "
            "WHERE employee_id = %s AND incident_id = %s",
            (new_emp, emp, inc)
        )
        conn.commit()
        print("Assignment updated.")

def remove_assignment(conn):
    emp = input("Employee ID: ").strip()
    inc = input("Incident ID: ").strip()
    with conn.cursor() as cursor:
        cursor.execute(
            "DELETE FROM handling_incident "
            "WHERE employee_id = %s AND incident_id = %s",
            (emp, inc)
        )
        if cursor.rowcount > 0:
            conn.commit()
            print("Assignment removed.")
        else:
            print("Error: No such assignment found.")

def manage_incidents_menu():
    conn = get_db_connection()
    if not conn:
        print("Failed to connect to database.")
        return

    while True:
        print("\n--- Manage Assignments---")
        print("1. Assign Incident")
        print("2. Update Incident Assignment")
        print("3. Remove Incident Assignment")
        print("4. Back to Main Menu")
        choice = input("Choice: ").strip()

        if choice == '1':
            assign_incident(conn)
        elif choice == '2':
            update_assignment(conn)
        elif choice == '3':
            remove_assignment(conn)
        elif choice == '4':
            break
        else:
            print("Invalid choice.")

    conn.close()
