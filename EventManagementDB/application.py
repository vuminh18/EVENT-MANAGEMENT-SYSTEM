import mysql.connector
from mysql.connector import Error

# --- 1. DATABASE CONNECTION ---
def create_connection():
    try:
        connection = mysql.connector.connect(
            host='127.0.0.1',
            database='EventManagementDB',
            user='root',         
            password='18021507' # Thay đổi password của bạn tại đây
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

# --- 2. REGISTRATION & EDITING MODULE ---
def register_guest(conn):
    """Đăng ký khách mời mới và lưu vào bảng Guests"""
    cursor = conn.cursor()
    name = input("Enter Guest Name: ")
    email = input("Enter Email: ")
    phone = input("Enter Phone: ")
    try:
        query = "INSERT INTO Guests (GuestName, Email, PhoneNumber) VALUES (%s, %s, %s)"
        cursor.execute(query, (name, email, phone))
        conn.commit()
        print(f"Successfully registered guest: {name}")
    except Error as e:
        print(f"Failed to register guest: {e}")

def edit_event(conn):
    """Chỉnh sửa thông tin sự kiện đã có trong bảng Events"""
    cursor = conn.cursor()
    event_id = input("Enter Event ID to edit: ")
    new_name = input("Enter new Event Name: ")
    new_date = input("Enter new Date (YYYY-MM-DD): ")
    try:
        query = "UPDATE Events SET EventName = %s, EventDate = %s WHERE EventID = %s"
        cursor.execute(query, (new_name, new_date, event_id))
        conn.commit()
        print("Event updated successfully!")
    except Error as e:
        print(f"Error updating event: {e}")

# --- 3. REPORTING MODULE ---
def generate_participation_report(conn):
    cursor = conn.cursor()
    query = """
        SELECT e.EventName, COUNT(r.RegistrationID) 
        FROM Events e
        LEFT JOIN Registrations r ON e.EventID = r.EventID
        GROUP BY e.EventID;
    """
    cursor.execute(query)
    
    print(f"\n{'Event Name':<50} {'Total Participants':<20}")
    print("-" * 70)
    
    for (name, count) in cursor.fetchall():
        print(f"{name:<50} {count:<20}")

def check_scheduling_conflicts(conn):
    """Conflict Detector: Identifies overlapping events to ensure integrity"""
    cursor = conn.cursor()
    query = """
        SELECT GROUP_CONCAT(EventName SEPARATOR ' & '), EventDate, VenueID 
        FROM Events
        GROUP BY EventDate, VenueID 
        HAVING COUNT(*) > 1;
    """
    try:
        cursor.execute(query)
        conflicts = cursor.fetchall()
        
        print("\n--- SCHEDULING CONFLICTS REPORT ---")
        if not conflicts:
            print("No conflicts found. All schedules are clear!")
        else:
            for row in conflicts:
                print(f"Conflict: [{row[0]}] on {row[1]} at Venue {row[2]}")
    except Exception as e:
        print(f"Error during conflict detection: {e}")

# --- 4. MAIN INTERFACE ---
def main():
    conn = create_connection()
    if not conn: return

    while True:
        print("\n===== EVENT MANAGEMENT SYSTEM =====")
        print("1. Register New Guest")
        print("2. Edit Existing Event")
        print("3. View Participation Report")
        print("4. Check Scheduling Conflicts")
        print("5. Exit")
        
        choice = input("Select an option (1-5): ")
        
        if choice == '1': register_guest(conn)
        elif choice == '2': edit_event(conn)
        elif choice == '3': generate_participation_report(conn)
        elif choice == '4': check_scheduling_conflicts(conn)
        elif choice == '5':
            conn.close()
            print("System closed. Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()