from database import get_db_connection
import pymysql

def show_supervisor(conn):
    emp = input("Employee ID: ").strip()
    with conn.cursor(pymysql.cursors.DictCursor) as cursor:
        # Validate employee exists
        cursor.execute("SELECT supervisor_id FROM employee WHERE employee_id = %s", (emp,))
        row = cursor.fetchone()
        if not row:
            print(f"Error: Employee {emp} does not exist.")
            return
        sup_id = row['supervisor_id']
        if not sup_id:
            print(f"Employee {emp} has no supervisor.")
            return
        # Fetch supervisor details
        cursor.execute("""
            SELECT employee_id, first_name, last_name, badge_num, `rank`, joining_date
            FROM employee 
            WHERE employee_id = %s
        """, (sup_id,))
        sup = cursor.fetchone()
        if sup:
            print("\nSupervisor Information:")
            for k, v in sup.items():
                print(f"{k}: {v}")
        else:
            print(f"Supervisor record {sup_id} not found.")

def show_subordinates(conn):
    sup = input("Supervisor Employee ID: ").strip()
    with conn.cursor(pymysql.cursors.DictCursor) as cursor:
        # Validate supervisor exists
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (sup,))
        if not cursor.fetchone():
            print(f"Error: Employee {sup} does not exist.")
            return
        # Fetch subordinates
        cursor.execute("""
            SELECT employee_id, first_name, last_name, badge_num, `rank`, joining_date
            FROM employee 
            WHERE supervisor_id = %s
        """, (sup,))
        rows = cursor.fetchall()
        if rows:
            print(f"\nSubordinates of {sup}:")
            for r in rows:
                print(f"{r['employee_id']} - {r['first_name']} {r['last_name']} "
                      f"(Badge: {r['badge_num']}, Rank: {r['rank']})")
        else:
            print(f"Employee {sup} has no subordinates.")

def add_supervisor(conn):
    emp = input("Employee ID to assign supervisor: ").strip()
    new_sup = input("Supervisor Employee ID: ").strip()
    with conn.cursor() as cursor:
        # Validate employee
        cursor.execute("SELECT supervisor_id FROM employee WHERE employee_id = %s", (emp,))
        row = cursor.fetchone()
        if not row:
            print(f"Error: Employee {emp} does not exist.")
            return
        if row[0]:
            print(f"Employee {emp} already has supervisor {row[0]}. Use update instead.")
            return
        # Validate new supervisor
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (new_sup,))
        if not cursor.fetchone():
            print(f"Error: Supervisor {new_sup} does not exist.")
            return
        # Assign
        cursor.execute(
            "UPDATE employee SET supervisor_id = %s WHERE employee_id = %s",
            (new_sup, emp)
        )
        conn.commit()
        print(f"Supervisor {new_sup} assigned to employee {emp}.")

def update_supervisor(conn):
    emp = input("Employee ID to update supervisor: ").strip()
    with conn.cursor() as cursor:
        # Check existing
        cursor.execute("SELECT supervisor_id FROM employee WHERE employee_id = %s", (emp,))
        row = cursor.fetchone()
        if not row:
            print(f"Error: Employee {emp} does not exist.")
            return
        current = row[0]
        if not current:
            print(f"Employee {emp} has no existing supervisor. Use add instead.")
            return
    new_sup = input("New Supervisor Employee ID: ").strip()
    with conn.cursor() as cursor:
        # Validate new
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (new_sup,))
        if not cursor.fetchone():
            print(f"Error: Supervisor {new_sup} does not exist.")
            return
        # Update
        cursor.execute(
            "UPDATE employee SET supervisor_id = %s WHERE employee_id = %s",
            (new_sup, emp)
        )
        conn.commit()
        print(f"Supervisor for employee {emp} updated from {current} to {new_sup}.")

def manage_supervisors_menu():
    conn = get_db_connection()
    if not conn:
        print("Failed to connect to database.")
        return

    while True:
        print("\n--- Supervisors Lookup Menu ---")
        print("1. Show Supervisor of Employee")
        print("2. Show Subordinates of Supervisor")
        print("3. Add Supervisor")
        print("4. Update Supervisor")
        print("5. Back to Main Menu")
        choice = input("Choice: ").strip()

        if choice == '1':
            show_supervisor(conn)
        elif choice == '2':
            show_subordinates(conn)
        elif choice == '3':
            add_supervisor(conn)
        elif choice == '4':
            update_supervisor(conn)
        elif choice == '5':
            break
        else:
            print("Invalid choice.")

    conn.close()
