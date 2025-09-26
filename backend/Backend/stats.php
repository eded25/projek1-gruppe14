<?php
require __DIR__.'/config.php';
header('Content-Type: application/json; charset=utf-8');

$stati = ['pending','approved']; // "aktive" Termine
// optional: barber_id-Filter für Friseur-Dashboard
$barberId = isset($_GET['barber_id']) ? (int)$_GET['barber_id'] : null;
$flt = $barberId ? " AND s.barber_id=?" : "";
$params = $barberId ? [$barberId] : [];

$t = $pdo->prepare("SELECT COUNT(*) FROM reservation r
                    JOIN appointment_slot s ON s.slot_id=r.slot_id
                    WHERE DATE(s.date_time)=CURDATE()
                      AND r.status IN ('pending','approved') $flt");
$t->execute($params);
$today = (int)$t->fetchColumn();

$w = $pdo->prepare("SELECT COUNT(*) FROM reservation r
                    JOIN appointment_slot s ON s.slot_id=r.slot_id
                    WHERE YEARWEEK(s.date_time,1)=YEARWEEK(CURDATE(),1)
                      AND r.status IN ('pending','approved') $flt");
$w->execute($params);
$week = (int)$w->fetchColumn();

echo json_encode(['status'=>'success','today'=>$today,'week'=>$week]);
