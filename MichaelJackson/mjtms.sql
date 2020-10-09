CREATE DATABASE mjtms;
USE mjtms;

####################
# User Management  #
####################

CREATE TABLE USER (
  USER_ID char(8) NOT NULL,
  USER_NAME varchar(50) ,
  USER_PASS varchar(50) ,
  USER_POS varchar(50) ,
  USER_DESC varchar(200) ,
  USER_GENDER char(1) ,
  USER_CONTACT varchar(20) ,
  USER_EMAIL varchar(50) ,
  USER_TYPE varchar(10),
  PRIMARY KEY (USER_ID)
) ;

CREATE TABLE ADMIN (
  USER_ID char(8) NOT NULL,
  PRIMARY KEY (USER_ID),
  FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE
) ;

CREATE TABLE TRAINER (
  USER_ID char(8) NOT NULL,
  PRIMARY KEY (USER_ID),
 FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE
) ;

CREATE TABLE TRAINEE (
  USER_ID char(8) NOT NULL,
  PRIMARY KEY (USER_ID),
 FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE
) ;

INSERT INTO USER VALUES ('adm00001', 'adminName','admin1234', 'adminPosition', 'adminDescription', 'm', '999', 'admin@tms.com', 'admin');
INSERT INTO USER VALUES ('tnr00001', 'trainerName','trainer1234', 'trainerPosition', 'trainerDescription', 'f', '012-7654321', 'trainer@tms.com', 'trainer');
INSERT INTO USER VALUES ('tne00001', 'traineeName','trainee1234', 'traineePosition', 'traineeDescription', 'm', '012-1234567', 'trainee@tms.com', 'trainee');
INSERT INTO USER VALUES ('tnr00002', 'trainerName','trainer1234', 'trainerPosition', 'trainerDescription', 'f', '012-7654321', 'trainer@tms.com', 'trainer');
INSERT INTO USER VALUES ('tne00004', 'Programmer','trainee1234', null, null, null, null, null, 'trainee');

DELETE FROM USER 
	WHERE USER_ID = 'tne00003';
    
UPDATE USER 
	SET USER_NAME = 'Ivan Pro' 
	WHERE USER_ID = 'tne00001';

SELECT USER_ID FROM USER;
SELECT * FROM USER;

INSERT INTO ADMIN VALUES ('adm00001');
SELECT * FROM ADMIN;

INSERT INTO TRAINER VALUES ('tnr00001');
INSERT INTO TRAINER VALUES ('tnr00002');
SELECT * FROM TRAINER;

INSERT INTO TRAINEE VALUES ('tne00001');
INSERT INTO TRAINEE VALUES ('tne00002');
SELECT * FROM TRAINEE;

###################################
# Training Course Management      #
###################################

CREATE TABLE TRAINING_COURSE (
COURSE_ID CHAR(8) NOT NULL,
USER_ID CHAR(8) NOT NULL,
COURSE_NAME VARCHAR(50),
COURSE_DESC VARCHAR(200),
COURSE_DATE DATE,
FEEDBACK_LINK VARCHAR(200),
PRIMARY KEY(COURSE_ID),
FOREIGN KEY(USER_ID) REFERENCES TRAINER(USER_ID) ON DELETE CASCADE
) ;

CREATE TABLE ENROLL (
USER_ID CHAR(8) NOT NULL,
COURSE_ID CHAR(8) NOT NULL,
TRAINING_STATUS VARCHAR(10),
PRIMARY KEY(USER_ID,COURSE_ID),
FOREIGN KEY(USER_ID) REFERENCES TRAINEE(USER_ID) ON DELETE CASCADE,
FOREIGN KEY(COURSE_ID) REFERENCES  TRAINING_COURSE(COURSE_ID)  ON DELETE CASCADE
) ;

CREATE TABLE COURSE_MATERIAL(
MATERIAL_ID CHAR(8) NOT NULL,
COURSE_ID CHAR(8) NOT NULL,
MATERIAL_TITLE VARCHAR(50),
MATERIAL_DESC VARCHAR(200),
PRIMARY KEY(MATERIAL_ID),
FOREIGN KEY(COURSE_ID) REFERENCES TRAINING_COURSE(COURSE_ID)
) ;

INSERT INTO TRAINING_COURSE VALUES ('crs00001', 'tnr00001','Python Training', 'Basic programming training', '2020-9-14');
INSERT INTO TRAINING_COURSE VALUES ('crs00002', 'tnr00002','Ruby On Rails', 'Learn enough to be dangerous', '2020-10-02');
INSERT INTO TRAINING_COURSE VALUES ('crs00003', 'tnr00002','Andriod Studio', 'Start from a simple app', '2020-10-05');
INSERT INTO TRAINING_COURSE VALUES ('crs00004', 'tnr00002','dotNet', 'Service Framework', '2020-10-08');

UPDATE TRAINING_COURSE
	SET COURSE_ID = 'crs00003'
    WHERE USER_ID = 'tnr00001';
DELETE FROM TRAINING_COURSE
	WHERE COURSE_ID = 'trc00001';

SELECT * FROM TRAINING_COURSE;

INSERT INTO COURSE_MATERIAL VALUES ('mtr00001', 'crs00001', 'material 1', 'Hello Word');
INSERT INTO COURSE_MATERIAL VALUES ('mtr00002', 'crs00001', 'Built in data type', 'Variables can store data of different types, and different types can do different things.');
INSERT INTO COURSE_MATERIAL VALUES ('mtr00003', 'crs00001', 'Advance', 'Object Oriented Programming');
INSERT INTO COURSE_MATERIAL VALUES ('mtr00004', 'crs00002', 'Scaffold ', 'Scaffolding provides more than cheap demo thrills');
INSERT INTO COURSE_MATERIAL VALUES ('mtr00005', 'crs00002', 'Rails Migration ', 'https://www.tutorialspoint.com/ruby-on-rails/rails-migrations.htm');
INSERT INTO COURSE_MATERIAL VALUES ('mtr00006', 'crs00003', 'Installation', 'Download from https://developer.android.com/studio/');

UPDATE COURSE_MATERIAL
	SET MATERIAL_TITLE = 'newDetails'
	WHERE MATERIAL_ID = 'mtr00001';
DELETE FROM COURSE_MATERIAL
	WHERE COURSE_ID = 'trc00001';
SELECT MATERIAL_ID FROM COURSE_MATERIAL 
	WHERE COURSE_ID = 'crs00002';
    
SELECT * FROM COURSE_MATERIAL;

INSERT INTO ENROLL VALUES ('tne00001', 'crs00002', 'approved');
INSERT INTO ENROLL VALUES ('tne00002', 'crs00003', 'approved');
INSERT INTO ENROLL VALUES ('tne00004', 'crs00004', 'approved');

UPDATE ENROLL
	SET TRAINING_STATUS = 'approved'
	WHERE COURSE_ID = 'crs00002';
SELECT COURSE_ID FROM ENROLL 
	WHERE USER_ID = 'tne00001' 
    AND TRAINING_STATUS = 'approved' ;
SELECT USER_ID FROM ENROLL
	WHERE TRAINING_STATUS = 'approved';    
SELECT * FROM ENROLL;

########################################
# Progress and Evaluation Management   #
########################################

CREATE TABLE REPORT(
REPORT_ID CHAR(8) NOT NULL,
COURSE_ID CHAR(8) NOT NULL,
PRIMARY KEY(REPORT_ID),
FOREIGN KEY(COURSE_ID) REFERENCES TRAINING_COURSE(COURSE_ID) ON DELETE CASCADE
) ;

CREATE TABLE PROGRESS(
USER_ID CHAR(8) NOT NULL,
MATERIAL_ID CHAR(8) NOT NULL,
MATERIAL_IS_DONE  VARCHAR(5),
PRIMARY KEY(USER_ID,MATERIAL_ID),
FOREIGN KEY(USER_ID) REFERENCES TRAINEE(USER_ID) ON DELETE CASCADE,
FOREIGN KEY(MATERIAL_ID) REFERENCES COURSE_MATERIAL(MATERIAL_ID) ON DELETE CASCADE
) ;

INSERT INTO PROGRESS VALUES ('tne00001','mtr00004','false');
INSERT INTO PROGRESS VALUES ('tne00001','mtr00005','false');
INSERT INTO PROGRESS VALUES ('tne00002','mtr00006','false');

UPDATE PROGRESS
	SET MATERIAL_IS_DONE = 'false'
	WHERE USER_ID = 'tne00001' AND MATERIAL_ID = 'mtr00007';
SELECT MATERIAL_IS_DONE FROM PROGRESS 
	WHERE USER_ID = 'tne00001' 
    AND MATERIAL_ID = 'mtr00001';
    
SELECT * FROM PROGRESS;

#################
#  Trigger      #
#################

CREATE TRIGGER UpdateTrainee 
    AFTER INSERT  
        ON USER FOR EACH ROW  
        INSERT INTO TRAINEE(USER_ID)
        (SELECT USER.USER_ID FROM USER 
        WHERE USER.USER_ID NOT IN(SELECT TRAINEE.USER_ID FROM TRAINEE) AND USER.USER_TYPE ='trainee');

CREATE TRIGGER UpdateTrainer 
    AFTER INSERT  
        ON USER FOR EACH ROW  
        INSERT INTO TRAINER(USER_ID)
        (SELECT USER.USER_ID FROM USER 
        WHERE USER.USER_ID NOT IN(SELECT TRAINER.USER_ID FROM TRAINER) AND USER.USER_TYPE ='trainer');
        
<<<<<<< HEAD
CREATE TRIGGER UpdateMarkAsDone
	AFTER INSERT
		ON COURSE_MATERIAL FOR EACH ROW
         INSERT INTO PROGRESS
        
=======
        
        
        
        
##########
desc progress;
select * from course_material;
select * from progress;
select * from enroll;
select * from user;
insert into progress values ('tne00001', 'mtr00003', 'false');
delete from enroll where user_ID = 'tne00001' AND course_id = 'crs00001';
>>>>>>> 62b06df5e333368323087fdeacc1904d43bc9960
