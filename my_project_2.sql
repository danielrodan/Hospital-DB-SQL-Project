-- Project 2 SQL Data Analysis
-- By: Daniel Rodan

USE Hospital
GO

-- Task number 1
SELECT py.[Name]
FROM Undergoes un LEFT JOIN Trained_In tr 
ON un.Physician = tr.Physician AND un.or_procedure = tr.Treatment
LEFT JOIN Physician py 
ON un.Physician = py.EmployeeID
WHERE tr.CertificationDate IS NULL

-- Task number 2
SELECT py.[name]
FROM Undergoes un LEFT JOIN Trained_In tr
ON un.Physician = tr.Physician AND un.or_procedure = tr.Treatment
LEFT JOIN Physician py
ON un.Physician = py.EmployeeID
WHERE tr.CertificationExpires < un.DateUndergoes

-- Task number 3
SELECT pt.[name] AS patient_name, py.[name] AS physician_name,
       nu.[name] AS nurse_name, ap.start_time AS start_time,
	   ap.end_time AS end_time, ap.examinationroom AS room,
	   pr_py.[name] AS primary_physician
FROM Appointment ap LEFT JOIN Patient pt
ON ap.Patient = pt.SSN
LEFT JOIN Physician py
ON ap.Physician = py.EmployeeID
LEFT JOIN Nurse nu
ON ap.PrepNurse = nu.EmployeeID
LEFT JOIN Physician pr_py
ON pr_py.EmployeeID = pt.PCP
WHERE ap.Physician <> pt.PCP

-- Task number 4
SELECT st.stayid AS stay, un.patient AS patient_id_from_undergoes,
       st.patient AS patient_id_from_stay
FROM Stay st JOIN Undergoes un
ON st.StayID = un.Stay
WHERE st.Patient <> un.Patient

-- Task number 5
SELECT nu.[name]
FROM Nurse nu JOIN On_Call oc
ON nu.EmployeeID = oc.Nurse
JOIN Room rm
ON rm.BlockCode = oc.BlockCode AND rm.BlockFloor = oc.BlockFloor
WHERE rm.RoomNumber = 123

-- Task number 6
SELECT ExaminationRoom, COUNT(*) AS number
FROM Appointment
GROUP BY ExaminationRoom

-- Task number 7
SELECT pt.[name] 
FROM Patient pt JOIN Prescribes pr
ON pt.SSN = pr.Patient
WHERE pr.Physician = pt.PCP

-- Task number 8
SELECT pt.[name]
FROM Patient pt JOIN Undergoes un
ON pt.SSN = un.Patient
JOIN or_procedure op
ON op.Code = un.or_procedure
WHERE op.Cost > 5000

-- Task number 9
SELECT pt.[name], COUNT (*) AS num_of_appointments
FROM Patient pt JOIN Appointment ap
ON pt.SSN = ap.Patient
GROUP BY pt.[Name]
HAVING COUNT (*) >= 2

-- Task number 10
SELECT pt.[name]
FROM Patient pt LEFT JOIN Department dp
ON pt.PCP = dp.Head
WHERE dp.Head IS NULL