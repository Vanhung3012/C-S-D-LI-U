/* Học phần: Cơ sở dữ liệu
   Người thực hiện: ????
   MSSV: ????
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab01_QLNV -- lenh khai bao CSDL
go
use Lab01_QLNV
go
--lenh tao cac bang theo thứ tự đã xác định
create table ChiNhanh
(MSCN	char(2) primary key,		 --khai bao MSCN la khoa chinh cua ChiNhanh
TenCN	nvarchar(30) not null unique --khai bao TenCN không được để trống và không được nhập trùng
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN)--khai báo MSCN là khóa ngoại của bảng NhanVien
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=1)
primary key(MANV,MSKN)--Khai báo NhanVienKyNang có khóa chính gồm 2 thuộc tính (MaNV, MSKN)

)
-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhập dữ liệu cho bảng Chi nhánh
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--delete from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy --định dạng nhập dữ liệu ngày tháng theo kiểu ngày tháng năm
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
--xem bang NhanVienKyNang
select * from NhanVienKyNang
--Xem tất cả các quan hệ có trong CSDL
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
-----------------------------------------------------------------------
---------------------------TRUY VẤN DỮ LIỆU----------------------------
--q1: cho biết các nhân viên làm việc tại chi nhánh có mã số chi nhánh '01'
select	*
From	NhanVien
where	MSCN = '01'
--q2: cho biết các nhân viên sinh sau năm 1975
select	*
From	NhanVien
where	year(NgaySinh)>1975
--q3: cho biết các nhân viên làm việc tại chi nhánh có mã số chi nhánh '03' có năm sinh sau 1975
select	*
From	NhanVien
where	mscn = '03' and year(NgaySinh)>1975
--q4: liệt kê các nhân viên có họ 'Lê'
select	*
From	NhanVien
where	Ho = N'Lê'
---------
select	*
From	NhanVien
where	Ho like N'Lê %'
---------
select	*
From	NhanVien
where	Ho like N'%Lê%'
--q5: cho biết các thông tin sau của nhân viên: MaNV, Ho, Ten, NgaySinh, MSCN
select	MaNV, Ho, Ten, NgaySinh, MSCN
From	NhanVien
--q6: cho biết các thông tin sau của nhân viên: MaNV, HoTen, năm sinh, số năm công tác
select	MaNV, Ho+' '+Ten as HoTen, year(NgaySinh) as NamSinh, year(getdate())-year(NgayVaoLam) as SoNamCT
From	NhanVien
--q7: cho biết các thông tin sau của nhân viên làm việc tại chi nhánh '03': MaNV, HoTen, năm sinh, số năm công tác
select	MaNV, Ho+' '+Ten as HoTen, year(NgaySinh) as NamSinh, year(getdate())-year(NgayVaoLam) as SoNamCT
From	NhanVien
where	mscn = '03'
--Tích nhân viên và chi nhánh
select	MaNV, Ho+' '+Ten as HoTen, year(NgaySinh) as NamSinh, TenCN, year(getdate())-year(NgayVaoLam) as SoNamCT
from	NhanVien, ChiNhanh
order by MaNV  -- oder by : sắp xếp mặc định tăng, DESC để giảm
--Phép kết | phép nối nhân viên và chi nhánh
select	*
from	NhanVien, ChiNhanh
where	NhanVien.MSCN = ChiNhanh.MSCN
--Q1c) Liệt kê các nhân viên (HoTen, TenKN, MucDo) biết sử dụng ‘Word’
Select	Ho +' '+Ten as HoTen, TenKN, MucDo
From	NhanVien, NhanVienKyNang, KyNang
Where	NhanVien.MANV = NhanVienKyNang.MANV and NhanVienKyNang.MSKN = KyNang.MSKN 
		and TenKN = 'Word'
--sử dụng bí danh (alias)
Select	Ho +' '+Ten as HoTen, TenKN, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C
Where	A.MANV = B.MANV and B.MSKN = C.MSKN 
		and TenKN = 'Word'
--Q1d) Liệt kê các kỹ năng (TenKn, MucDo) mà nhân viên 'Lê Anh Tuấn' sử dụng được 
Select	TenKN, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C
--Where	A.MANV = B.MANV and B.MSKN = C.MSKN and Ho=N'Lê Anh' and Ten = N'Tuấn'
Where	A.MANV = B.MANV and B.MSKN = C.MSKN and Ho +' '+Ten =N'Lê Anh Tuấn'
--Q3a) Với mỗi chi nhánh, hãy cho biết tên chi nhánh và số nhân viên của chi nhánh đó.
Select	TenCN,COUNT(MaNV) As SoNV
From	ChiNhanh A, NhanVien B
Where	A.MSCN = B.MSCN
Group by	TenCN
--Q3b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó). 
Select	 TenKN, COUNT(MaNV) As SoNguoiDung
From	NhanVienKyNang A, KyNang B
Where	A.MSKN = B.MSKN
Group by	A.MSKN, TenKN
--Q3c) Cho biết tên kỹ năng có từ 3 người sử dụng trở lên (có không dưới 3 người sử dụng)
Select	 TenKN, COUNT(MaNV) As SoNguoiDung
From	NhanVienKyNang A, KyNang B
Where	A.MSKN = B.MSKN
Group by	A.MSKN, TenKN
Having	COUNT(MaNV) >= 3 -- Having là điều kiện của Group by
