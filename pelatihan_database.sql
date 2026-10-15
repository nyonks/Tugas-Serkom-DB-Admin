-- 1. Tabel hrd_department
CREATE TABLE hrd_department (
    dept_cd VARCHAR(20) NOT NULL,
    dept_nm VARCHAR(100) NULL,
    order_no INTEGER NULL,
    created_by VARCHAR(20) NULL,
    created_at TIMESTAMP NULL,
    updated_by VARCHAR(20) NULL,
    updated_at DATE NULL,
    CONSTRAINT hrd_department_pkey PRIMARY KEY (dept_cd)
);

-- 2. Tabel com_code
CREATE TABLE com_code (
    com_cd VARCHAR(20) NOT NULL,
    code_nm VARCHAR(100) NULL,
    created_by VARCHAR(20) NULL,
    created_at TIMESTAMP NULL,
    updated_by VARCHAR(20) NULL,
    updated_at DATE NULL,
    CONSTRAINT com_code_pkey PRIMARY KEY (com_cd)
);

-- 3. Tabel hrd_employee
CREATE TABLE hrd_employee (
    emp_cd VARCHAR(20) NOT NULL,
    dept_cd VARCHAR(20) NOT NULL,
    emp_nm VARCHAR(100) NULL,
    address VARCHAR(500) NULL,
    salary NUMERIC(10,2) NULL,
    allowance NUMERIC(10,2) NULL,
    gender_tp CHAR(1) NULL,
    created_by VARCHAR(20) NULL,
    created_at TIMESTAMP NULL,
    updated_by VARCHAR(20) NULL,
    updated_at DATE NULL,
    CONSTRAINT hrd_employee_pkey PRIMARY KEY (emp_cd),
    CONSTRAINT fk_employee_department 
        FOREIGN KEY (dept_cd) 
        REFERENCES hrd_department (dept_cd)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


--psql -U postgres -d pelatihan <MHS-TABLE.sql -v ON_ERROR_STOP=1

/*--DROP TABLE IF EXISTS IF EXISTS--*/
DROP TABLE IF EXISTS public.gen_code CASCADE;
DROP TABLE IF EXISTS public.trx_kota CASCADE;
DROP TABLE IF EXISTS public.trx_mahasiswa CASCADE;
DROP TABLE IF EXISTS public.trx_mata_kuliah CASCADE;
DROP TABLE IF EXISTS public.trx_nilai CASCADE;
DROP TABLE IF EXISTS public.trx_kecamatan CASCADE;
DROP TABLE IF EXISTS public.trx_kelurahan CASCADE;
DROP TABLE IF EXISTS public.trx_kota CASCADE;
DROP TABLE IF EXISTS public.trx_propinsi CASCADE;

DROP TABLE IF EXISTS public.trx_wilayah CASCADE;


/*--Create Table--*/
CREATE TABLE gen_code
(
	gen_id               VARCHAR(20) NOT NULL,
	gen_nm               VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
	-- PRIMARY KEY (gen_id)
);

ALTER TABLE gen_code ADD PRIMARY KEY (gen_id);

CREATE TABLE trx_mahasiswa
(
	mhs_id               UUID NOT NULL,
	mhs_nm               VARCHAR(200) NULL,
	nim                  VARCHAR(200) NULL,
	nik                  VARCHAR(200) NULL,
	propinsi_id          VARCHAR(10) NOT NULL,
	kota_id              VARCHAR(10) NOT NULL,
	kecamatan_id         VARCHAR(10) NULL,
	kelurahan_id         VARCHAR(10) NULL,
	wilayah_id           VARCHAR(10) NULL,
	alamat               VARCHAR(500) NULL,
	tanggal_lahir        DATE NULL,
	gender               VARCHAR(20) NULL,
	agama                VARCHAR(20) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
	-- PRIMARY KEY (gen_id)
);

ALTER TABLE trx_mahasiswa ADD PRIMARY KEY (mhs_id);

ALTER TABLE public.trx_mahasiswa
ADD FOREIGN KEY (gender) REFERENCES public.gen_code (gen_id);

ALTER TABLE public.trx_mahasiswa
ADD FOREIGN KEY (agama) REFERENCES public.gen_code (gen_id);


CREATE TABLE trx_mata_kuliah
(
	mata_kuliah_id       BIGSERIAL NOT NULL,
	mata_kuliah_nm       VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);

ALTER TABLE trx_mata_kuliah
ADD PRIMARY KEY (mata_kuliah_id);

CREATE TABLE trx_nilai
(
	nilai_id             BIGSERIAL NOT NULL,
	mhs_id               UUID NOT NULL,
	mata_kuliah_id       BIGINT NOT NULL,
	nilai                NUMERIC(5,2) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);

ALTER TABLE trx_nilai
ADD PRIMARY KEY (nilai_id);


ALTER TABLE trx_nilai
ADD FOREIGN KEY (mhs_id) REFERENCES trx_mahasiswa (mhs_id);

ALTER TABLE trx_nilai
ADD FOREIGN KEY (mata_kuliah_id) REFERENCES trx_mata_kuliah (mata_kuliah_id);


CREATE TABLE trx_propinsi
(
	propinsi_id          VARCHAR(10) NOT NULL,
	propinsi_nm          VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);
ALTER TABLE trx_propinsi
ADD PRIMARY KEY (propinsi_id);

CREATE TABLE trx_kota
(
	kota_id              VARCHAR(10) NOT NULL,
	propinsi_id          VARCHAR(10) NOT null,
	kota_nm              VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);
ALTER TABLE trx_kota
ADD PRIMARY KEY (kota_id);

CREATE TABLE trx_kecamatan
(
	kecamatan_id         VARCHAR(10) NOT NULL,
	kota_id              VARCHAR(10) NOT null,
	kecamatan_nm         VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);
ALTER TABLE trx_kecamatan
ADD PRIMARY KEY (kecamatan_id);

CREATE TABLE trx_kelurahan
(
	kelurahan_id         VARCHAR(10) NOT NULL,
	kecamatan_id         VARCHAR(10) NOT null,
	kelurahan_nm         VARCHAR(200) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);
ALTER TABLE trx_kelurahan
ADD PRIMARY KEY (kelurahan_id);


CREATE TABLE trx_wilayah
(
	wilayah_id           VARCHAR(10) NOT NULL,
	wilayah_nm           VARCHAR(200) NULL,
	wilayah_root         VARCHAR(20) NULL,
	created_by           VARCHAR(100) NULL,
	created_at           TIMESTAMP NULL,
	updated_by           VARCHAR(100) NULL,
	update_at            TIMESTAMP NULL
);
ALTER TABLE trx_wilayah
ADD PRIMARY KEY (wilayah_id);


ALTER TABLE trx_kota
ADD FOREIGN KEY (propinsi_id) REFERENCES trx_propinsi (propinsi_id);

ALTER TABLE trx_kelurahan
ADD FOREIGN KEY (kecamatan_id) REFERENCES trx_kecamatan (kecamatan_id);

ALTER TABLE trx_kecamatan
ADD FOREIGN KEY (kota_id) REFERENCES trx_kota (kota_id);


ALTER TABLE trx_mahasiswa
ADD FOREIGN KEY (propinsi_id) REFERENCES trx_propinsi (propinsi_id);

ALTER TABLE trx_mahasiswa
ADD FOREIGN KEY (kota_id) REFERENCES trx_kota (kota_id);

ALTER TABLE trx_mahasiswa
ADD FOREIGN KEY (wilayah_id) REFERENCES trx_wilayah (wilayah_id);


---------------------------
INSERT INTO public.trx_nilai (mhs_id,mata_kuliah_id,nilai,created_by,created_at)
VALUES(public.fn_get_mhsid('25001')::uuid,1,80,'admin',CURRENT_TIMESTAMP);
INSERT INTO public.trx_nilai (mhs_id,mata_kuliah_id,nilai,created_by,created_at)
VALUES(public.fn_get_mhsid('25001')::uuid,2,70,'admin',CURRENT_TIMESTAMP);
INSERT INTO public.trx_nilai (mhs_id,mata_kuliah_id,nilai,created_by,created_at)
VALUES(public.fn_get_mhsid('25001')::uuid,3,70,'admin',CURRENT_TIMESTAMP);
INSERT INTO public.trx_nilai (mhs_id,mata_kuliah_id,nilai,created_by,created_at)
VALUES(public.fn_get_mhsid('25001')::uuid,4,50,'admin',CURRENT_TIMESTAMP);
select A.mhs_id,mhs_nm,alamat,tanggal_lahir,gender,B.gen_nm as jenis_kelamin,
sum(C.nilai) as total_nilai,count(C.nilai) jumlah_matkul,sum(C.nilai)/count(C.nilai) as rata2
from trx_mahasiswa A
left join gen_code B on A.gender=B.gen_id
join trx_nilai C on C.mhs_id=A.mhs_id
join trx_mata_kuliah D on C.mata_kuliah_id=D.mata_kuliah_id
group by A.mhs_id,mhs_nm,alamat,tanggal_lahir,gender,B.gen_nm;
select A.mhs_id,mhs_nm,alamat,tanggal_lahir,gender,B.gen_nm as jenis_kelamin,
D.mata_kuliah_id,C.nilai
from trx_mahasiswa A
left join gen_code B on A.gender=B.gen_id
join trx_nilai C on C.mhs_id=A.mhs_id
join trx_mata_kuliah D on C.mata_kuliah_id=D.mata_kuliah_id;


select A.mhs_id,mhs_nm,alamat,tanggal_lahir,gender,B.gen_nm as jenis_kelamin,
sum(C.nilai) as total_nilai,count(C.nilai) jumlah_matkul,sum(C.nilai)/count(C.nilai) as rata2
from trx_mahasiswa A
left join gen_code B on A.gender=B.gen_id
join trx_nilai C on C.mhs_id=A.mhs_id
join trx_mata_kuliah D on C.mata_kuliah_id=D.mata_kuliah_id
group by A.mhs_id,mhs_nm,alamat,tanggal_lahir,gender,B.gen_nm;
ALTER TABLE public.trx_nilai ALTER COLUMN nilai SET DEFAULT 0;

--------------------------------------
DROP VIEW IF EXISTS public.vw_wilayah;
CREATE OR REPLACE VIEW public.vw_wilayah
AS
select A.propinsi_id, A.propinsi_nm, '' as kota_id, '' as kota_nm, '' as kecamatan_id, '' as kecamatan_nm,
'' as kelurahan_id, '' as kelurahan_nm
from trx_propinsi A
union
select A.propinsi_id, A.propinsi_nm,B.kota_id, B.kota_nm, '' as kecamatan_id, '' as kecamatan_nm,
'' as kelurahan_id, '' as kelurahan_nm
from trx_kota B
join trx_propinsi A on B.propinsi_id=A.propinsi_id
union
select A.propinsi_id, A.propinsi_nm, B.kota_id, B.kota_nm, C.kecamatan_id, C.kecamatan_nm,
'' as kelurahan_id, '' as kelurahan_nm
from trx_kecamatan C
join trx_kota B on C.kota_id=B.kota_id
join trx_propinsi A on B.propinsi_id=A.propinsi_id
union
select A.propinsi_id, A.propinsi_nm, B.kota_id, B.kota_n…
-------------------------------------------
DROP FUNCTION IF EXISTS public.sp_test01;
CREATE OR REPLACE FUNCTION public.sp_test01()
RETURNS table(
	r_emp_cd varchar(10), r_dept_cd varchar(10), r_emp_nm varchar(100)
)
AS
$$
BEGIN
	RETURN query
	SELECT A.emp_cd,A.dept_cd,A.emp_nm
	FROM public.hrd_employee A
	WHERE A.dept_cd='HRD';
END;
$$
LANGUAGE plpgsql;

---------------------------------
SELECT * FROM public.sp_test01();
-----------------------------------
DROP FUNCTION IF EXISTS public.sp_test02;
CREATE OR REPLACE FUNCTION public.sp_test02(pDeptCd varchar(10))
RETURNS table(
	r_emp_cd varchar(10), r_dept_cd varchar(10), r_emp_nm varchar(100), r_dept_nm varchar(100)
)
AS
$$
BEGIN
	RETURN query
	SELECT A.emp_cd,A.dept_cd,A.emp_nm,B.dept_nm
	FROM public.hrd_employee A
	JOIN public.hrd_department B ON A.dept_cd=B.dept_cd
	WHERE A.dept_cd=pDeptCd;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM public.sp_test02('HRD');