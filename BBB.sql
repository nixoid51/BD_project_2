/*   Вывести именно фамилию сотрудника с самой высокой зарплатой  */

SELECT  fio 
  FROM employees  
  WHERE salary = ( 
                  SELECT MAX(salary) 
                    FROM  employees 
                  );

/*   Вывести фамилии сотрудников в алфавитном порядке   */

SELECT DISTINCT fio 
  FROM employees;

/*   Вывести средний стаж для каждого уровня сотрудников   */

SELECT level, AVG(CURRENT_DATE - begin_date) AS career 
  FROM employees  
  GROUP BY level;

/*   Вывести фамилию сотрудника и название отдела, в котором он работает   */

ALTER TABLE employees ADD FOREIGN KEY (id_depart) REFERENCES department;

SELECT employees.fio, department.name  
  FROM employees, department  
  WHERE employees.id_depart =  department.id_depart;  

/*   Вывести название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также   */

SELECT  d.name, em.fio, MAX(em.salary) AS max_salary 
  FROM department d, employees em 
  WHERE d.id_depart =  em.id_depart AND salary IN (
                                    SELECT MAX(salary) 
                                        FROM  employees 
                                        GROUP BY id_depart
                                    ) 
  GROUP BY d.name, em.fio; 
