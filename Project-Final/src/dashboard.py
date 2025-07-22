import pymysql
import sys
import file_complaint
import employee_lookup
import complaint_lookup
import manage_evidences
import manage_incidents
import manage_supervisors
from database import get_db_connection

def check_employee_exists(employee_id):
    conn = get_db_connection()
    if not conn:
        return None
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    query = "SELECT employee_id, first_name, last_name FROM employee WHERE employee_id = %s LIMIT 1"
    cursor.execute(query, (employee_id,))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result

def login():
    while True:
        emp_id = input("Enter your Employee ID (or 'exit' to quit): ")
        if emp_id.lower() == 'exit':
            sys.exit(0)
        employee = check_employee_exists(emp_id)
        if employee:
            print(f"Login successful.\nWelcome {employee['first_name']} {employee['last_name']} to the NYPD Police Database.\n")
            return employee
        else:
            print("Employee ID not found. Try again.")

def main_dashboard(employee):
    while True:
        print("\n--- Main Dashboard ---")
        print("1. File a Incident")
        print("2. Employee Manager")
        print("3. Lookup Incident")
        print("4. Manage Evidences")
        print("5. Manage Assignments")
        print("6. Supervisor Lookup")
        print("7. Logout")
        choice = input("Enter your choice: ")
        if choice == '1':
            file_complaint.file_complaint()
        elif choice == '2':
            employee_lookup.employee_lookup_menu()
        elif choice == '3':
            complaint_lookup.complaint_lookup_menu()
        elif choice == '4':
            manage_evidences.manage_evidences()
        elif choice == '5':
            manage_incidents.manage_incidents_menu()
        elif choice == '6':
            manage_supervisors.manage_supervisors_menu()
        elif choice == '7':
            print("Logging out...")
            break
        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    employee = login()
    main_dashboard(employee)
