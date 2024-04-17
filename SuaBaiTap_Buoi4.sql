select *
from cgtrinh
where ngay_bd between '9-1-1994' and '10-20-1994'

--22. Cho bi?t tên và ??a ch? c?a các 
--công trình mà công nhân Nguy?n H?ng Vân ?ang tham gia vào ngày 18/12/1994

select a.*
from cgtrinh a, congnhan b, thamgia c
where a.STT_ctr = c.stt_ctr and
      b.hoten_cn = c.hoten_cn and
      b.hoten_cn = 'nguyen hong van' and
      '12-18-1994' between ngay_bd and (ngay_bd+so_ngay)
      
--Cho bi?t h? tên ki?n trúc s? v?a thi?t k? các công trình do Phòng d?ch v? S? Xây
--d?ng thi công, v?a thi?t k? các công trình do ch? th?u Lê V?n S?n thi công

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
--24. Cho bi?t h? tên các công nhân có tham gia các công trình ? C?n Th? nh?ng không
--tham gia công trình ? V?nh Long

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
--25. Cho bi?t tên c?a các ch? th?u ?ã thi công các công trình có kinh phí l?n h?n t?t c?
--các công trình do ch? th?u Phòng d?ch v? s? xây d?ng thi công

select a.ten_thau
from chuthau a, cgtrinh b
where a.ten_thau = b.ten_thau and
      kinh_phi > ALL (
            select KINH_PHI
            from chuthau a, cgtrinh b
            where a.ten_thau = b.ten_thau and
                  a.ten_thau='phong dich vu so xd')
--26. Cho bi?t h? tên các ki?n trúc s? có thù lao thi?t k? cho m?t công trình nào ?ó d??i
--giá tr? trung bình thù lao thi?t k? c?a các KTS.
select hoten_kts
from  thietke 
where thu_lao <  (select avg(THU_lao)
                    from thietke)

--27. Cho bi?t h? tên các công nhân có t?ng s? ngày tham gia vào các công trình l?n h?n
--t?ng s? ngày tham gia c?a công nhân Nguy?n H?ng Vân
select hoten_cn,sum(so_ngay) as tong_ngay
from thamgia
group by hoten_cn
having sum(so_ngay)> (
                            select  sum(so_ngay)
                            from thamgia
                            where hoten_cn ='nguyen hong van'
                            )
--28. Cho bi?t h? tên công nhân có tham gia t?t c? các công trình

select hoten_cn, count(stt_ctr)
from thamgia
group by hoten_cn
having count(stt_ctr) = (select count(*) from cgtrinh)


--29. Tìm các c?p tên c?a ch? th?u có trúng th?u các công trình t?i cùng m?t thành ph?

select distinct chuthau1.ten_thau , chuthau2.ten_thau
from cgtrinh  chuthau1, cgtrinh  chuthau2
where chuthau1.tinh_thanh = chuthau2.tinh_thanh and
      chuthau1.ten_thau > chuthau2.ten_thau

--30. Tìm các c?p tên c?a các công nhân có lamg vi?c chung v?i nhau trong ít nh?t là hai công trình
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