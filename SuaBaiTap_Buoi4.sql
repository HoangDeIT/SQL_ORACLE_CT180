select *
from cgtrinh
where ngay_bd between '9-1-1994' and '10-20-1994'

--22. Cho bi?t t�n v� ??a ch? c?a c�c 
--c�ng tr�nh m� c�ng nh�n Nguy?n H?ng V�n ?ang tham gia v�o ng�y 18/12/1994

select a.*
from cgtrinh a, congnhan b, thamgia c
where a.STT_ctr = c.stt_ctr and
      b.hoten_cn = c.hoten_cn and
      b.hoten_cn = 'nguyen hong van' and
      '12-18-1994' between ngay_bd and (ngay_bd+so_ngay)
      
--Cho bi?t h? t�n ki?n tr�c s? v?a thi?t k? c�c c�ng tr�nh do Ph�ng d?ch v? S? X�y
--d?ng thi c�ng, v?a thi?t k? c�c c�ng tr�nh do ch? th?u L� V?n S?n thi c�ng

select a.*
from ktrucsu a, thietke b, cgtrinh c
where a.hoten_kts = b.hoten_kts and
      b.stt_ctr = c.stt_ctr and
      ten_thau = 'phong dich vu so xd' and
      a.hoten_kts IN (
                        select a.hoten_kts
                        from ktrucsu a, thietke b, cgtrinh c
                        where a.hoten_kts = b.hoten_kts and
                              b.stt_ctr = c.stt_ctr and
                              ten_thau = 'le van son'
                              )
--24. Cho bi?t h? t�n c�c c�ng nh�n c� tham gia c�c c�ng tr�nh ? C?n Th? nh?ng kh�ng
--tham gia c�ng tr�nh ? V?nh Long

select distinct a.*
from congnhan a, thamgia b, cgtrinh c
where a.hoten_cn = b.hoten_cn and 
     b.stt_ctr = c.stt_ctr and
     tinh_thanh = 'can tho' and
     a.hoten_cn NOT IN (
                    select a.hoten_cn
                    from congnhan a, thamgia b, cgtrinh c
                    where a.hoten_cn = b.hoten_cn and 
                         b.stt_ctr = c.stt_ctr and
                         tinh_thanh = 'vinh long')
--25. Cho bi?t t�n c?a c�c ch? th?u ?� thi c�ng c�c c�ng tr�nh c� kinh ph� l?n h?n t?t c?
--c�c c�ng tr�nh do ch? th?u Ph�ng d?ch v? s? x�y d?ng thi c�ng

select a.ten_thau
from chuthau a, cgtrinh b
where a.ten_thau = b.ten_thau and
      kinh_phi > ALL (
            select KINH_PHI
            from chuthau a, cgtrinh b
            where a.ten_thau = b.ten_thau and
                  a.ten_thau='phong dich vu so xd')
--26. Cho bi?t h? t�n c�c ki?n tr�c s? c� th� lao thi?t k? cho m?t c�ng tr�nh n�o ?� d??i
--gi� tr? trung b�nh th� lao thi?t k? c?a c�c KTS.
select hoten_kts
from  thietke 
where thu_lao <  (select avg(THU_lao)
                    from thietke)

--27. Cho bi?t h? t�n c�c c�ng nh�n c� t?ng s? ng�y tham gia v�o c�c c�ng tr�nh l?n h?n
--t?ng s? ng�y tham gia c?a c�ng nh�n Nguy?n H?ng V�n
select hoten_cn,sum(so_ngay) as tong_ngay
from thamgia
group by hoten_cn
having sum(so_ngay)> (
                            select  sum(so_ngay)
                            from thamgia
                            where hoten_cn ='nguyen hong van'
                            )
--28. Cho bi?t h? t�n c�ng nh�n c� tham gia t?t c? c�c c�ng tr�nh

select hoten_cn, count(stt_ctr)
from thamgia
group by hoten_cn
having count(stt_ctr) = (select count(*) from cgtrinh)


--29. T�m c�c c?p t�n c?a ch? th?u c� tr�ng th?u c�c c�ng tr�nh t?i c�ng m?t th�nh ph?

select distinct chuthau1.ten_thau , chuthau2.ten_thau
from cgtrinh  chuthau1, cgtrinh  chuthau2
where chuthau1.tinh_thanh = chuthau2.tinh_thanh and
      chuthau1.ten_thau > chuthau2.ten_thau

--30. T�m c�c c?p t�n c?a c�c c�ng nh�n c� lamg vi?c chung v?i nhau trong �t nh?t l� hai c�ng tr�nh
-- Tim xem moi cap cong nhan lam chung voi nhau bao nhieu cong trinh
--Tim xem cong nhan lam chung cong trinh voi nhau
create table bangphu_30
(
    hotencn1 varchar(20),
    hotencn2 varchar(20),
    stt_ctr  int
)

insert into bangphu_30 
select distinct cn1.hoten_cn , cn2.hoten_cn, cn1.stt_ctr
from thamgia cn1, thamgia cn2
where cn1.stt_ctr = cn2.stt_ctr and
      cn1.hoten_cn < cn2.hoten_cn
      
      
select hotencn1, hotencn2,count(stt_ctr)
from bangphu_30
group by hotencn1, hotencn2
having count(stt_ctr)>=2