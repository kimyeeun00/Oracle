-- 11/22  4장 함수

-- 단일행 함수 : 행 하나당 적용되는 함수라는 뜻

select * from employees;
--- 대문자를 소문자로 , 소문자를 대문자로
select email, lower(email),initcap(email), first_name, upper(first_name), lower(first_name),
       length(first_name), lengthb(first_name), length('이숭무'), lengthb('이숭무')
from employees;

-- 1. 이름이 'steven' 인 사람을 출력하세요.
select * from employees where first_name = 'Steven';
select * from employees where lower(first_name) = 'steven';

-- 2. 성이 KING인 직원을 출력하세요.
select * from employees where upper(last_name) ='KING';

-- 3. 이름의 글자의 객수가 5인 사원을 출력하세요.
select * from employees where length(first_name) = 5;

-- 4. 급여가 5리 이상인 사원을 구하세요.
select * from employees where salary >= 10000;
select * from employees where length(salary) >= 5;

-- indexOf() : 문자열에서 원하는 문자가 있는 위치 번호 str.indexOf('a');
-- DB에서는  instr() : DB의 인덱스는 1부터 시작한다. 

-- 5. 이름에 's' 자를 가진 사원들 중 이름에 몇번째에 있는지를 출력하세요.
select first_name, instr(first_name,'s')
from employees;
-- 1 steven 은 1 이어야하는데 0 ? -> 대소문자 구분하기 때문 

-- 6. 이름에 's' 자가 세 번째에 있는 사원을 출력하세요.
select * from employees where instr(first_name,'s') = 3;

-- java : 
-- String str = "I love the java";
--               01234567
-- System.out.println(str.substring(7));
-- DB에서는 substr
-- 7. 이름과 성과 급여와 직무를 출력할 때 이메일은 3번째 글자부터 출력하세요.
select first_name, last_name, salary, job_id, email, substr(email,3)
from employees;

-- 8. 이메일에 's'부터 출력하고, 급여, 입사일, 이름 , 성을 출력하세요.
-- 없는 경우에는 instr() = 0 이게 되므로 처음부터 출력된다. 
select email, substr(email,instr(email,'S')), salary, hire_date, first_name, last_name
from employees;

-- String str = "I love the java";
--               0123456789
-- System.out.println(str.substring(7,7+3);
-- 9. 이름, 급여, 직무, 부서를 출력할 때 이메일은 3번째부터 3글자를 출력하세요.
-- substr(컬럼,a,b) : a 번째 글자부터 b개 글자를 가져와라
select first_name, salary, job_id, department_id, email, substr(email,3,4)
from employees;

-- 10. 이메일에 3번째 글자부터 4글자에 'ARTS'가 있는 사원을 출력하세요.
select * from employees where substr(email,3,4) = 'ARTS';

-- 11. 이메일에 's' 가 5번째에 있는 사원을 출력하세요.
select * from employees where substr(email,5,1) = 'S';
select * from employees where instr(lower(email), 's') = 5;
-- ????????????????? 2명 사라졌땅 


--- lower, upper, length, lengthb, initcap, substr, instr 

-- print("나의 나이는 %10d이다", % 30);
-- 나의 나이는           30이다

select salary, rpad(salary, 10, '*'), lpad(salary, 10, '*') from employees;
-- 아이디 찾기 highland0 : high*****
-- 12. 이메일에서 앞에서 2글자를 출력하고 나머지는 오른쪽에 * 로 채워서 출력하세요.
select email, rpad(substr(email,1,2), length(email), '*') from employees;

-- 13. 입사일이 03/06/17, 전화번호가 515.123.4567인 사원의 이메일을 앞에서 3글자만 출력하고 나머지는 * 로 출력하세요.
select rpad(substr(email,1,3),length(email),'*') 
from employees
where hire_date = '030617' and phone_number = '515.123.4567';

-- str. replace ("","")
-- 14. 직무가 _AS가 있다면 abc로 변경하세요.
select replace(job_id, '_AS', 'abc'), job_id
from employees
where job_id like ('%_AS%');

-- str.trim()
select '   이숭무   ' , trim('      이숭무    '), rtrim('    이숭무 '), ltrim('  이숭무')
from dual;
-- 공백문자가 아닐 경우에는 trim('문자' from 컬럼) 으로 사용하자.
-- 15. 이메일에서 'A'가 처음이나 끝에 있다면 삭제하여 출력하자.
select email,trim('A' from email), trim(email)
from employees;

-- str = 'abcdefg'
--        0123456
--        7654321
-- print (str[4:7])
-- print (str[-3:])

-- 16. 이메일에서 뒤에서 한 글자를 가지고오고, 또 이메일에서 뒤에서부터 2글자를 가지고오며, 이메일에서 뒤에서 3번쨰부터 2글자를 출력하세요.
select email, substr(email,-1,1), substr(email,-2,2), substr(email,-3,2)
from employees;

-- 17. 010-7146-1970, 010-****-1970, 02-314-1970, 02-***-1970

select rpad(substr('010-7146-1970',1,instr('010-7146-1970','-')),
       length(substr('010-7146-1970',1,instr('010-7146-1970','-',-1)-1)),'*')
       ||substr('010-7146-1970',-5,5)
from dual;

-- 18. 이름, 입사일, 부서번호, 급여, 연봉을 출력하세요.
select first_name, hire_date, department_id, salary, salary*12 
from employees;

-- 19. 이름, 입사일, 부서번호, 급여, 연봉을 출력할 때 연봉에는 커미션이 포함되어야한다. 
select first_name, hire_date, department_id, salary, (salary + salary * commission_pct) * 12
from employees;

--- nvl(컬럼,값) : 컬럼값이 null이면 값을 준다. 
select commission_pct, nvl(commission_pct,0)
from employees;
-- 20. 커미션이 null이라면 커미션 값을 0으로 대입하여 이름, 부서, 입사일, 직무, 급여, 커미션, 그리고 연봉을 출력하세요.
select first_name, department_id, hire_date, job_id, salary, commission_pct, 
       (salary + salary * nvl(commission_pct,0)) * 12
from employees;

select nvl(commission_pct, 100) from employees;


--- 숫자함수 
-- round() : 반올림
-- trunc() : 절삭 
-- mod()   : 나머지

-- 21. 반올림하세요 : 5부터 반올림된다. 
select round(15.19345,3), round(15.19355,3), round(145.5545,2), round(142.5554,1),
       round(145.5554,0), round(145.4554,0), round(145.5554,-1), round(145.5554,-2)
from dual;

-- 22. 절삭하세요 : 버림 
select trunc(15.19345,3), trunc(15.19355,3), trunc(145.5545,2), trunc(142.5554,1),
       trunc(145.5554,0), trunc(145.4554,0), trunc(145.5554,-1), trunc(145.5554,-2)
from dual;

-- 23. 입사일로부터 오늘날짜까지 며칠이 지났는지 일로 출력하세요.
-- 입사일, 이름, 성, 직무도 함께출력.

select sysdate from dual;
select hire_date, first_name, last_name, job_id, trunc(sysdate - hire_date,0)
from employees;

-- 24. 입사일, 이름, 성, 직무를 출력할 때 입사일로부터 몇 주가 지났는지 출력하세요.
select sysdate from dual;
select hire_date, first_name, last_name, job_id, round((sysdate - hire_date)/7) as week
from employees;

-- 25. 입사일, 이름, 성, 직무를 출력할 때 입사일로부터 몇 년차인지 출력하세요.
select sysdate from dual;
select hire_date, first_name, last_name, job_id, round((sysdate - hire_date)/365) year 
from employees;

-- 26. 년차가 17년 이상인 사원을 출력하세요.
select * from employees where (sysdate-hire_date)/365 >= 17;

-- 10/3 : 10%3 : mod(10,3)
select mod(10,3) from dual;

-- 27. 이름, 성, 입사일, 급여를 출력할 때 급여를 400으로 나눈 나머지를 출력하세요.
select first_name, last_name, hire_date, salary, mod(salary,400) from employees;

-- 28. 급여를 500으로 나눈 나머지가 400이상인 사원들을 출력하세요.
select * from employees where mod(salary,500) >= 400;

-- 10을 3으로 나눈 몫 int i = 10, int j = 3, result = i / j
--                  double d = 10, double d1 = 3, result = (int)(d/d1) 강제형변환
select 10/3 from dual;
select trunc(10/3) from dual;


--- 날짜 함수 
-- 29. 오늘 날짜부터 다음 금요일은 며칠입니까?
select next_day(sysdate, '금'), next_day(sysdate, '금요일')
from dual;

-- 30. 이름, 성, 직무, 입사일을 출력할 때 입사일로부터 다음 목요일이 언제였는지 출력하세요.
select first_name, last_name, job_id, hire_date, next_day(hire_date,'목')
from employees;

-- add_months(a,b) : a날짜에 b개월을 더한다 
-- 오늘부터 3개월 후는 며칠입니까? 
select add_months(sysdate,3)
from dual;

-- 31. Neena 가 입사하고 3개워 후가 정직원이 되는 날이다.
-- 정직원이 되는 날이 언제인지, 이름, 성, 입사일, 직무, 사워버호와 함께 출력하세요.
select first_name, last_name, hire_date, job_id, department_id, add_months(hire_date,3)
from employees
where first_name = 'Neena';

-- 32. 입사한 이후 다음 목요일이 '01/01/18' 인 사원을 구하세요.
select * from employees where next_day(hire_date,'목') = '010118';

-- last_day() : 마지막 날을 출력
select last_day(sysdate) 
from dual;

-- 33. 윤달에 입사한 사원을 출력하세요.
select * from employees where last_day(hire_date) like '%/02/29%' ;

--- months_between(a,b) : a-b 개월수 
-- 34. 입사일로부터 현재까지 몇 달이 지났는지 이름, 성, 직무, 입사일과 함께 출력하세요.
select first_name, last_name, job_id, hire_date, trunc(months_between(sysdate,hire_date))
from employees;

-- 35. 각 사원이 직무를 담당한 달은 몇 달인지 출력하세요.
select employee_id, job_id, start_date, end_date, round(months_between(end_date,start_date))
from job_history;

-- 36. 입사한지 200개월이 지난 사원들을 출력하세요.
select * from employees where months_between(sysdate,hire_date) >= 200;


--- 변환함수 

--- 날짜 변환 2021-05-14 11:10:35 (date)
-- 20   21   05   14   11   10   35
-- 세기  년   월   일   시    분   초
-- 21/05/14 : 2021/05/14 : 49년도까지가 현재 세기를 갖고온다.
-- 50/05/14 : 2050/05/14가 아니라 1950/05/14 로 가져온다.
-- 2050/05/14 라고 적어줘야 2050년을 가져온다. 
-- 즉 50년부터 99년까지는 이전세기를 가져온다. 

-- to_date('a','b') : a를 date 형식으로 바꾸어준다. b는 a의 년월일 순을 알려준다. 
-- b 는 a 문자열의 형식을 적어주어야한다. 
select trunc(sysdate - to_date('21-01-15'))
from dual;
select trunc(sysdate - to_date('21-01-15','yy-mm-dd'))
from dual;

-- '01-05-2021' : 월일년의 경우
select sysdate - to_date ('01/05/2021','mm/dd/yyyy')
from dual;

-- 03/06/17 이후에 입사한 사원을 출력하세요.
select * from employees where hire_date > '03/06/17';
select * from employees where hire_date > to_date('03/06/17','yy-mm-dd');

-- 38. 17/06/03 (일월년) 이후에 입사한 사람은?
select * from employees where hire_date > to_date('17/06/03','dd-mm-yy');

--- 문자 변환 : 보통 날짜를 문자로 변환
--             yy-mm-dd
-- to_char('a','b') : a를 b의 형식의 문자로 바꾸어준다. b에는 원하는 형식을 적어주면 된다.
select sysdate, to_char(sysdate, 'yy-mm-dd'), to_char(sysdate,'dd-mm-yy'), to_char(sysdate,'yyyy-mm-dd') from dual;
select sysdate, to_char(sysdate, 'yyyy-mm-dd hh:mi:ss AM'), to_char(sysdate, 'yyyy-mm-dd hh:mi:ss.ssss AM'),
                to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss AM'), to_char(sysdate, 'yyyy-mon-dd hh:mi:ss AM')
from dual;

--- 문자열로 날짜 비교
-- 문자는 사전 순서이기 때문에 날짜를 문자로 비교할 경우 결과가 다르게 나올 수 있기 때문에
-- 날짜를 문자로 바꾸는 게 아니라 "문자열을 날짜 바꿔서 비교"하도록 하자. 
-- 40. 25-04-2003 보다 늦게 입사한 사람을 출력하세요.
select * from employees where hire_date > to_date('25-04-2003','dd-mm-yyyy');
select * from employees where to_char(hire_date,'dd-mm-yyyy') > '25-04-2003'; -- 잘못된 비교방법 

-- 숫자를 문자열로
-- 1,234,567 => w1,234,567, $1,234,567, $1,234,567-
select to_char(1234567.890, '9,999,999'),
       to_char(1234567.890, '9,999,999.00'),
       to_char(1234567.890, '$9,999,999.00'),
       to_char(1234567.890, 'L9,999,999.00'),
       to_char(-1234567.890, 'L9,999,999.00mi')
from dual;

-- 41. 이름, 성, 직무부서 그리고 급여를 세자리씩 , 를 찍고 $ 가 출력되게 하시오
select first_name, last_name, job_id, department_id,
       to_char(salary,'$99,9999,999mi'),
       to_char(-salary,'$99,9999,999mi') -- 회계파트에서 많이 사용된다 minus 뒤에 붙이기 
from employees;

-- 42. janette 또는 JANETTE 또는 jaNette의 값을 전달받았다.
-- 이름이 'Janette' 인 사원을 출력하세요.
select * from employees where first_name = initcap('janette') or first_name = initcap('JANETTE') or first_name = initcap('jaNette');        --1
select * from employees where lower(first_name) = 'janette' or upper(first_name) = 'JANETTE' or lower(first_name) = lower('jaNette');       --2
-- 2번이 낫다 왜냐하면 컬럼의 값에 전달 받은 값을 맞춘느 것이 편하기때문이다. 

--- java 표현식 : switch(변수) ~ case 조건 : 연산식 break ; default : 연산식 
--          case 변수 when 조건 then 연산식 else 연산식 end

-- 43. job_id가 'IT_PROG' 이면 급여를 10% 상승, 'ST_CLERK' 15% 상승
--'SA_REP' 20% 상승시켜 출력하고 이외는 급여를 그대로 출력해라
select first_name, last_name, salary, job_id,
case job_id when 'IT_PROG' then salary + salary * 0.1
            when 'ST_CLERK' then salary + salary * 0.15
            when 'SA_REP' then salary + salary * 0.2
            else salary end sal
from employees;

select first_name, last_name, salary, job_id,
case when job_id = 'IT_PROG' then salary + salary * 0.1
     when job_id = 'ST_CLERK' then salary + salary * 0.15
     when job_id = 'SA_REP' then salary + salary * 0.2
     else salary end sal
from employees;

-- 44. 성, 이름, 직무, 급여, 급여에 따른 직책도 같이 출력하세요.
--급여가 3000 이하면 사원
--      5000 이하 주임
--      7000 이하 대리
--      9000 이하 과장
--      11000 이하 차장
--      13000 이하 부장
--      그 이상은 임원

select last_name, first_name, job_id, salary,
case when salary <= 3000 then '사원'
     when salary <= 5000 then '주임'
     when salary <= 7000 then '대리'
     when salary <= 9000 then '과장'
     when salary <= 11000 then '차장'
     when salary <= 13000 then '부장'
     else '임원' end grade
from employees;

-- 45. 급여에 따른 세금을 출력하고자 한다. 이름, 성, 급여, 직무, 세금을 출력하세요.
--급여를 2000으로 나눈 몫이 0이면 급여의 0%
--                        1이면 급여의 9%
--                        2이면 급여의 20%
--                        3이면 급여의 30%
--                        4이면 급여의 40%
--                        5이면 급여의 42%
--                        6이면 급여의 44%
--                        이외 급여의 45% 가 세금이다
select first_name, last_name, salary, job_id,
case when trunc(salary/2000) = 0 then salary*0.00
     when trunc(salary/2000) = 1 then salary*0.09
     when trunc(salary/2000) = 2 then salary*0.2
     when trunc(salary/2000) = 3 then salary*0.3
     when trunc(salary/2000) = 4 then salary*0.4
     when trunc(salary/2000) = 5 then salary*0.42
     when trunc(salary/2000) = 6 then salary*0.44
     else trunc(salary*0.45) end tex
from employees;

select first_name, last_name, salary, job_id,
case trunc(salary/2000) when 0 then salary*0.00
                        when 1 then salary*0.09
                        when 2 then salary*0.2
                        when 3 then salary*0.3
                        when 4 then salary*0.4
                        when 5 then salary*0.42
                        when 6 then salary*0.44
                        else trunc(salary*0.45) end tex
from employees;

select first_name, last_name, salary, job_id,
decode (job_id, 'IT_PROG' , salary + salary * 0.1
              , 'ST_CLERK' , salary + salary * 0.15
              , 'SA_REP' , salary + salary * 0.2
              , salary )sal
from employees;  

select first_name, last_name, salary, job_id,
decode( trunc(salary/2000) , 0 , salary*0.00
                           , 1 , salary*0.09
                           , 2 , salary*0.2
                           , 3 , salary*0.3
                           , 4 , salary*0.4
                           , 5 , salary*0.42
                           , 6 , salary*0.44
                           , trunc(salary*0.45) ) tex
from employees;



--- 숙제 
-- 문자함수
-- Lower, Upper, initcap, concat, substr

-- 1. 성이 모두 소문자인 grant와 모두 대문자인 'GRANT'로 직원테이블에서 해당 사원을 찾으려 한다.  (Grant) 
select * from employees where lower(last_name) = 'grant' or upper(last_name) = 'GRANT';

-- 2. 'GranT'로 입력했을때 사원테이블에서 성이 'Grant'인 사원을 찾으시오.
select * from employees where last_name = initcap('GranT');

-- 3. 성은 모두 대문자로 변환하고 이름 모두 소문자로 변환하여
-- 성과 이름을 붙여 출력할 때 ' 나는 GRANT douglas 입니다'로 출력되게 하시오.
select '나는 '||upper(last_name)||' '||lower(first_name)||' 입니다.' from employees;

-- concat
-- 4. 성과 이름을 붙여 출력
select concat(last_name,first_name) from employees;

-- 5.  성은 모두 대문자로 변환하고 이름 모두 소문자로 변환하여 성과 이름을 붙여 출력할 때 ' 나는 GRANT douglas 입니다'로 출력되게 하시오. concat을 이용
select '나는 '||concat(upper(last_name),lower(first_name))||' 입니다.' from employees;

/* 참고 시작
오라클과 비교
String str = "abcdefghi";
String result = str.subString(2, 6); //cdef
String result = str.subString(2); //cdefghi
참고 끝 */ 

-- 6. 성이 Davies에서 av만 출력하시오.
select substr(last_name,2,2) from employees where last_name = 'Davies';

-- 7. 성이 두번째 글자부터 모두 출력하시오.
select last_name,substr(last_name,2) from employees;

-- 8. 성의 마지막 글자에서 두글자만 가져오시오.
select last_name,substr(last_name,-2) from employees;

-- 9. 성의 뒤에 on으로 끝나는 사람을 찾으시오.
select * from employees where substr(last_name,-2) = 'on';

-- 10. 성의 뒤에 세번째 글자가 so인 사람을 출력하시오.
select * from employees where substr(last_name,-3) like 'so%';

-- 11. 직원 정보를 출력하는데 이메일은 왼쪽에서 3글자만 출력하시오. 직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, substr(email,1,3)
from employees;

-- 12. 직원 정보를 출력하는데 이메일은 오른쪽에서 3글자만 출력하시오. 직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, substr(email,-3)
from employees;

-- 13. 직원 정보를 출력하는데 이메일은 오른쪽에서 3글자만 출력하고 나머지는 ‘-’로 출력 직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, lpad(substr(email,1,3),length(email),'-')
from employees;

/* 참고 시작
String str ="abcdefg";
int i = str.indexOf("f");  //5
참고 끝 */

-- 14. o가 있는 성중 o가 몇번째에 있는 위치인지 출력하시오. --- 아래 참조하기 직원번호 성, 성의 위치, 직무
select employee_id, last_name, instr(last_name,'o'),job_id
from employees;

-- 15. oc가 있는 성중 oc가 몇번째에 있는 위치인지 출력하시오. -- 아래 참조하기  직원번호 성, 성의 위치, 직무
select employee_id, last_name, instr(last_name,'oc'),job_id
from employees;

/* 참고 시작
instr(last_name,'oc') : 원하는 문자가 없으면 0을 반환
instr('abcde' , 'a') : 1
자바에서 "abcdef".indexOf("a") : 0
참고 끝 */

-- 16. 직무에 RE가 있는 경우 RE부터 3글자만 출력하시오. 직원번호 성,  직무, 가공된 직무
select employee_id, last_name, job_id,
case when job_id like '%RE%' then substr(job_id,instr(job_id,'RE'))
     else job_id end JOB_ID
from employees;

-- 17. 직원번호, 성, 입사일 , 급여를 10칸에 출력하고 나머지 공간 앞에 * 표시가 되게 하자.
select lpad(employee_id, 10, '*'),
       lpad(last_name, 10, '*'),
       lpad(hire_date, 10, '*'),
       lpad(salary, 10, '*')
from employees;

-- 18. 직원번호, 성, 입사일 , 급여를 10칸에 출력하고 나머지 공간 뒤에 * 표시가 되게 하자.
select rpad(employee_id, 10, '*'),
       rpad(last_name, 10, '*'),
       rpad(hire_date, 10, '*'),
       rpad(salary, 10, '*')
from employees;

-- 19.  직원번호, 성, 입사일, 직무를 출력하는데 직무에 RE가 있다면 RE를 AB로 변경하여 출력
select employee_id, last_name, hire_date,
case when job_id like '%RE%' then replace(job_id,'RE','AB')
     else job_id end JOB_ID
from employees;

/* 참고 시작
select trim(' ab cd ef ') 
from dual;

select trim(' ' from ' ab cd ef ') 
from dual;

select trim('a' from 'abada')
from dual;

select round(45.923, 2), round(45.924, 2), round(45.925, 2),
       round(45.926, 2)
from dual;


select trunc(45.923, 2), trunc(45.924, 2), trunc(45.925, 2),
       trunc(45.926, 2)
from dual;

select  round(45.925, 2),round(45.925, 1), round(45.925),
	round(45.925, -1), round(45.925, -2)
from dual;


select  trunc(45.925, 2), trunc(45.925, 1), trunc(45.925),
	trunc(45.925, -1), trunc(45.925, -2)
from dual;


select mod(10,3)
from dual;
참고 끝 */

-- 20. 직원번호, 연락처, 커미션, 부서번호,급여,급여를 3000으로 나누었을 때의 나머지를 출력하시오.
select employee_id, phone_number, commission_pct, salary, mod(salary,3000)
from employees;

-- 21. 2002년도부터 입사한 직원들을 출력하시오.
select * from employees where hire_date > '020101';

-- 22. 올해는 오늘까지 몇주가 지났는지 확인하시오.
select trunc((sysdate - to_date('2020-01-01'))/7) 
from dual; 

-- 23. 직원마다 몇년 근무했지를 출력하시오. 직원번호, 성, 연락처,부서, 근무년수
select employee_id, last_name, phone_number, job_id, trunc((sysdate-hire_date)/365)
from employees;

-- 24. 근속년수 8년 이상인 사원들만 출력하시오.
select * from job_history;
select * from job_history where trunc((end_date-start_date)/365) >= 8;

-- 25. 예시 : 게시판리스트에서 제목을 5글자****인 것 처럼 직원의 성을 3글자만 출력 뒤에 *을 세번찍어서 출력하시오. 직원번호, 입사일, 성
select employee_id, hire_date, rpad(substr(last_name,1,3),6,'*') from employees;

-- 26. 홍길동은 몇글자입니까? -- 영문 ‘abc’와 비교
select lengthb('홍길동') from dual;
select lengthb('abc') from dual;

-- 27. "홍길동 \n"으로 되어 있는 것을 html에서 행 바꿈이되도록 "홍길동 <br>"변경하시오.
select replace('홍길동\n','홍길동\n','홍길동<br>') from dual;

-- 28. 입사일이 'YYYY-MM-DD'인 날짜를 31-05-2019 16:24:30 오전인 형태로 출력하자.
select to_char(hire_date,'dd-mm-yyyy hh:mi:ss am') from employees;

-- 29. 숫자(3333333)를 3자리마다 쉼표를 찍어서 출력
select to_char(3333333, '9,999,999') from dual;

-- 30. 직원테이블에서 급여를 W33,333,333식으로 출력하시오.
select to_char(salary,'L9,999,999') from employees;

-- 31. 직원의 2018-10-25까지의 근무일수를 계산하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, to_date('2018-10-25','yyyy-mm-dd')-hire_date 
from employees;
-- 32. 직원의 25-10-2018까지의 근무일수를 계산하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, to_date('25-10-2018','dd-mm-yyyy')- hire_date
from employees;

-- 33. 직원의 10-25-2018까지의 근무일수를 계산하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, to_date('10-25-2018','mm-dd-yyyy')- hire_date
from employees;

-- 34. '10-25-2002'에 입사한 사원을 출력하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, trunc(sysdate-hire_date)
from employees 
where hire_date = to_date('08-17-2002','mm-dd-yyyy');

-- 35. 연말정산을 하려고 합니다. 연봉(급여*12) : 급여는 커미션까지 포함된다.
-- 직원의 연봉을 구하시오.  직원번호, 부서번호, 급여, 연봉
select employee_id, department_id, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees;

-- 36. 부서가 90이거나 30인 부서의 직원의 연봉을 구하시오. 직원번호, 부서번호, 급여, 연봉
select employee_id, department_id, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees
where department_id = 90 or department_id = 30;

-- 37. 직원 번호와 성과 급여 그리고 연봉을 출력하시오.
select employee_id, last_name, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees;




-- 표현식
-- 38. 급여가 10000이상이면 "이사급입니다"
--            7000이상이면 "부장급입니다"
--            5000이상이면 "과장급입니다"
--            나머지는 사원으로 출력하시오.
--            성과 급여를 같이 출력한다.
-- case

-- 39. 급여를 2000으로 나눈 값의 몫이 
--       0이면 0.00
--       1이면 0.09
--       2이면 0.20
--       3이면 0.30
--       4이면 0.40
--       5이면 0.42
--       6이면 0.44
--             0.45 만큼 세금이 부여된다.
--부여되는 세금을 출력하시오.
--성과 급여도 같이 출력하시오.(단, 부서가 80인 사원만)


-- 40. 직원 전체에서 입사일이 제일빠른 사람과 최근에 입사한 사원을 출력하시오.

-- 41. 급여의 1000단위를 반올림하여 출력하시오.

-- 42. 사원번호가 짝수인 사원만 출력하시오

-- 43. 사원번호가 홀수인 사원을 출력하시오.

-- 44. 사원의 급여가 3000에서 6000 사이의 사원을 출력하시오,

-- 45. 사원의 급여가 3000에서 6000 사이의 급여를 받지 못하는 사원을 출력하시오,

-- 46. 사원들이 입사한지 몇 주가 되었는 출력하시오.

-- 47. 사원들 중 1000주가 지난 사원들만 출력하시오.

-- 48. 사원들이 입사한지 몇년이 되었는지 출력하시오.

-- 49. email에서 첫음부터 2글자, 2번째부터 2글짜 , 3번째 부터 2글자를 출력하시오.

-- 50. 10-25-2003보다 나중에 들어온 사원을 출력하시오.

-- 51. 사원들이 커미션을 포함하는 연봉을 구하시오.

-- 52. 50, 60, 90인 부서가 아닌 사원들을 구하시오

-- 53. 날짜가 10-20-2003보다 먼저 입사한 사원을 모두 출력하시오. 이때 Steven의 입사일은 10-20-2003입니다

-- 54. 사원이름, 급여, 연봉 을 구하시오. 커미션이 없는 경우 커미션을 0으로 한다. 연봉이 높은 사람 부터 출력하시오.

-- 55. 위 예제에서 부서가 60이거나 90인 사원만 출력하시오


