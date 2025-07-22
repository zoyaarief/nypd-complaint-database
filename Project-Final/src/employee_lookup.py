
from database import get_db_connection
import pymysql

def show_employee_by_id(emp_id):
    conn = get_db_connection()
    if not conn:
        return
    try:
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        query = """
            SELECT employee_id, first_name, last_name, badge_num, `rank`, joining_date
            FROM employee
            WHERE employee_id = %s
        """
        cursor.execute(query, (emp_id,))
        result = cursor.fetchone()
        if result:
            print("\nEmployee Information:")
            for k, v in result.items():
                print(f"{k}: {v}")
        else:
            print("Employee not found.")
    except Exception as e:
        print(f"Error retrieving employee: {e}")
    finally:
        cursor.close()
        conn.close()

def show_employee_by_badge(badge_num):
    conn = get_db_connection()
    if not conn:
        return
    try:
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        query = """
            SELECT employee_id, first_name, last_name, badge_num, `rank`, joining_date
            FROM employee
            WHERE badge_num = %s
        """
        cursor.execute(query, (badge_num,))
        result = cursor.fetchone()
        if result:
            print("\nEmployee Information:")
            for k, v in result.items():
                print(f"{k}: {v}")
        else:
            print("Employee not found.")
    except Exception as e:
        print(f"Error retrieving employee: {e}")
    finally:
        cursor.close()
        conn.close()

def add_employee(conn):
    first = input("Enter First Name: ").strip().capitalize()
    last = input("Enter Last Name: ").strip().capitalize()
    badge = input("Enter Badge Number: ").strip()
    rank = input("Enter Rank: ").strip().capitalize()
    joining_date = input("Enter Joining Date (YYYY-MM-DD): ").strip()
    supervisor = input("Enter Supervisor ID (leave blank if none): ").strip() or None

    cursor = conn.cursor()
    # Badge uniqueness
    cursor.execute("SELECT 1 FROM employee WHERE badge_num = %s", (badge,))
    if cursor.fetchone():
        print(f"Error: Badge number {badge} already in use.")
        cursor.close()
        return
    # Supervisor validity
    if supervisor:
        cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (supervisor,))
        if not cursor.fetchone():
            print(f"Error: Supervisor ID {supervisor} does not exist.")
            cursor.close()
            return

    try:
        cursor.execute(
            "INSERT INTO employee (first_name, last_name, badge_num, `rank`, joining_date, supervisor_id) "
            "VALUES (%s,%s,%s,%s,%s,%s)",
            (first, last, badge, rank, joining_date, supervisor)
        )
        conn.commit()
        new_employee = cursor.lastrowid
        cursor.execute(
            "SELECT employee_id FROM employee WHERE badge_num = %s",
            (badge,)
        )
        row = cursor.fetchone()

        new_emp_id = row[0] if row else None

        if new_emp_id:
            print(f"\nEmployee added successfully! Generated Employee ID: {new_emp_id}")
        print(f"Employee added successfully.")
    except Exception as e:
        conn.rollback()
        print(f"Error adding employee: {e}")
    finally:
        cursor.close()

def update_employee_fields(conn):
    emp_id = input("Enter Employee ID to update: ").strip()
    cursor = conn.cursor()
    cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (emp_id,))
    if not cursor.fetchone():
        print(f"Error: Employee {emp_id} not found.")
        cursor.close()
        return

    while True:
        field = input("Field to update (first_name,last_name,badge_num,rank,joining_date,supervisor_id): ").strip()
        if field not in ['first_name','last_name','badge_num','rank','joining_date','supervisor_id']:
            print("Invalid field.")
            continue
        new_val = input(f"Enter new value for {field}: ").strip()
        # Capitalize names/rank
        if field in ['first_name','last_name','rank']:
            new_val = new_val.capitalize()
        # Badge uniqueness
        if field == 'badge_num':
            cursor.execute("SELECT 1 FROM employee WHERE badge_num = %s AND employee_id != %s", (new_val, emp_id))
            if cursor.fetchone():
                print(f"Error: Badge {new_val} already in use.")
                continue
        # Supervisor validity
        if field == 'supervisor_id' and new_val:
            cursor.execute("SELECT 1 FROM employee WHERE employee_id = %s", (new_val,))
            if not cursor.fetchone():
                print(f"Error: Supervisor {new_val} not found.")
                continue

        try:
            cursor.execute(f"UPDATE employee SET {field} = %s WHERE employee_id = %s", (new_val, emp_id))
            conn.commit()
            print(f"{field} updated to {new_val}.")
        except Exception as e:
            conn.rollback()
            print(f"Error updating {field}: {e}")

        if input("Update another? (y/n): ").strip().lower() != 'y':
            break
    cursor.close()

def delete_employee(conn, employee_id):
    try:
        with conn.cursor() as cursor:
            cursor.execute("DELETE FROM handling_incident WHERE employee_id = %s", (employee_id,))
            if cursor.rowcount > 0:
                print(f"Deleted {cursor.rowcount} handling_incident rows.")
            else:
                print(f"Employee {employee_id} was handling no incident.")

            cursor.execute("SELECT COUNT(*) FROM employee WHERE supervisor_id = %s", (employee_id,))
            sub_count = cursor.fetchone()[0]
            if sub_count > 0:
                cursor.execute("UPDATE employee SET supervisor_id = NULL WHERE supervisor_id = %s", (employee_id,))
                print(f"Removed supervision for {sub_count} subordinate(s).")
            else:
                print(f"Employee {employee_id} had no subordinates.")

            cursor.execute("DELETE FROM employee WHERE employee_id = %s", (employee_id,))
            if cursor.rowcount == 1:
                print(f"Employee {employee_id} deleted.")
            else:
                print(f"No employee {employee_id} found.")
        conn.commit()
    except Exception as e:
        conn.rollback()
        print(f"Error deleting employee: {e}")

def employee_lookup_menu():
    conn = get_db_connection()
    if not conn:
        return
    while True:
        print("\n--- Employee Manager Menu ---")
        print("1. Lookup by Employee ID")
        print("2. Lookup by Badge Number")
        print("3. Update Employee Fields")
        print("4. Add Employee")
        print("5. Delete Employee")
        print("6. Back to Main Menu")
        choice = input("Choice: ").strip()
        if choice == '1':
            show_employee_by_id(input("ID: ").strip())
        elif choice == '2':
            show_employee_by_badge(input("Badge: ").strip())
        elif choice == '3':
            update_employee_fields(conn)
        elif choice == '4': 
             add_employee(conn)
        elif choice == '5':
            delete_employee(conn, input("ID: ").strip())
        elif choice == '6':
            break
        else:
            print("Invalid choice.")
    conn.close()
