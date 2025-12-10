# 3. Functional Requirements
## 3.1 Smart Queue System

### Student:
**
FQ1: Student can select a service queue (Registrar, Department, Clearance, etc.)

FQ2: Student receives queue number

FQ3: Student receives real-time updates: position, estimated time, “Come Now” reminder

FQ4: Student receives notification when their turn is near**

### Admin:

FQ5: Admin can view all queued students

FQ6: Admin can call next student

FQ7: Admin can mark student as "served"

FQ8: System logs queue history

## 3.2 Online Registration (Freshmen & Returning)
Freshmen Registration

FRS1: Student fills Application Form online (based on university’s PDF)

FRS2: Student fills Cost-Sharing Form online

FRS3: System generates PDF version of the completed form

FRS4: PDF stored in Firebase Storage

FRS5: Student receives submission confirmation

Readmission / Returning Students

RRS1: Student fills Cost-Sharing Form only

RRS2: System auto-generates PDF

RRS3: Student books an appointment with registrar or department

RRS4: Registrar approves/signs in person

## 3.3 Clearance Workflow

Clearance is required for students:

Taking semester break

Withdrawing

Dropping out

Graduating

### Student:

CLS1: Student fills Clearance Form online

CLS2: PDF automatically generated

CLS3: Clearance workflow created with steps:

***Proctor

Department

Library

Cafeteria

Discipline

Registrar
***
CLS4: Student can see which offices approved or rejected

CLS5: Student can book appointment for final registrar approval

### Admin:

CLA1: Each office reviews the form

CLA2: Each office can approve, reject, or comment

CLA3: Office adds digital signature

CLA4: Registrar performs final approval

## 3.4 Appointment Booking System

### Student:

ABS1: Student selects office (Registrar, Department, Library, Clearance)

ABS2: Student selects available date & timeslot

ABS3: Student receives confirmation

### Admin:

ABA1: Admin sets available appointment slots

ABA2: Admin views daily/weekly appointment lists

ABA3: Admin can cancel a slot (notifies student)

## 3.5 Digital Forms & PDF Handling

PDF1: System uploads official university PDF templates

PDF2: Student enters input values in UI fields

PDF3: System fills the template PDF

PDF4: Final PDF saved to Firebase Storage

PDF5: Admin can download or view PDFs

## 3.6 User Authentication

AUTH1: Students log in using student ID + phone/email

AUTH2: Admins log in with roles

AUTH3: Role-based dashboard access

## 3.7 Notifications

NOT1: Queue update notifications

NOT2: Appointment reminders

NOT3: Form status updates

NOT4: Admin comments or rejection notices

# 4. Non-Functional Requirements
## 4.1 Performance Requirements

Real-time queue updates (<1 second latency)

PDF generation within 5 seconds

App must support 5,000+ concurrent users

## 4.2 Security Requirements

Firebase Authentication

Role-based access control

PDFs stored in secure Storage buckets

Admin actions logged for accountability

## 4.3 Reliability Requirements

System uptime > 99%

Auto-retry for failed writes

Offline mode for reading previous forms

## 4.4 Usability Requirements

Intuitive UI for students with simple navigation

Accessible via low-end Android phones

Dashboard easy for staff with minimal training

# 5. User Roles & Permissions
Students

Join queue

Fill forms

Book appointments

View approvals

Download PDFs

Registrar

Manage queues

Approve forms

## Sign cost-sharing & clearance forms

Oversee workflow

Departments (12 offices)

Review cost-sharing

Approve clearance

Proctors

## Approve clearance housing section

Cafeteria Office

## Approve clearance related to food services

Library Office

## Approve clearance related to borrowed materials

Discipline Office

## Approve discipline status

Super Admin

Manage roles

Configure system

# 6. System Workflow (Step-by-Step)
## 6.1 Freshman Registration Workflow

Student installs app

Logs in / first-time registration

Fills application form online

Fills cost-sharing form online

System generates PDF

Student books appointment with registrar

Student arrives physically

Registrar verifies documents

Registrar digitally signs

Status becomes “Registered”

## 6.2 Returning Student Registration Workflow

Student logs in

Fills cost-sharing form

Generates PDF

Books appointment (optional based on schedule)

Registrar/department approves

## 6.3 Clearance Workflow

Student fills clearance form online

System creates approval workflow

Each office approves in sequence:

Proctor → Department → Library → Cafeteria → Discipline → Registrar

Registrar gives final approval

Student receives clearance certificate PDF

## 6.4 Smart Queue Workflow

Student selects service (Registrar/Department/Library/etc.)

System assigns queue number

Student monitors position

Notification sent when nearing turn

Staff calls next

Student gets service

Status is updated to “Served”

## 6.5 Appointment Workflow

Student chooses office

Selects date & time

Confirm appointment

Admin sees booking

Admin can approve or cancel