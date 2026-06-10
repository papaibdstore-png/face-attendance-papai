ระบบสแกนหน้าเข้า-ออกงาน V3
Supabase + Telegram + Netlify

ไฟล์ในชุดนี้:
1. index.html
2. register.html
3. scan.html
4. supabase-config.js
5. database.sql
6. supabase/functions/send-telegram/index.ts

ภาพรวมระบบ:
- พนักงานกดเริ่มสแกน
- ระบบจับใบหน้า
- ระบบแสดงชื่อ + เวลา + สถานะ เช่น ปกติ / สายกี่นาที / ออกเกินเวลากี่นาที
- พนักงานกดยืนยัน
- ระบบบันทึกลง Supabase
- ระบบส่งรูป + ข้อมูลเข้า Telegram Group

ขั้นตอนติดตั้ง:
1) สร้าง Project ใน Supabase
2) ไปที่ SQL Editor แล้วรัน database.sql
3) เอา Project URL และ anon public key มาใส่ใน supabase-config.js
4) สร้าง Telegram Bot ด้วย BotFather และเก็บ BOT_TOKEN
5) สร้างกลุ่ม Telegram เพิ่ม Bot เป็น Admin แล้วหา CHAT_ID
6) Deploy Supabase Edge Function:
   supabase login
   supabase link --project-ref YOUR_PROJECT_REF
   supabase secrets set TELEGRAM_BOT_TOKEN=ใส่_BOT_TOKEN
   supabase secrets set TELEGRAM_CHAT_ID=ใส่_CHAT_ID
   supabase functions deploy send-telegram
7) อัปโหลด index.html, register.html, scan.html, supabase-config.js ขึ้น Netlify

ตั้งเวลาเข้างาน/ออกงาน:
แก้ในไฟล์ scan.html ตรง WORK_RULES

คำเตือน:
ห้ามใส่ Telegram BOT_TOKEN ใน HTML/JS ฝั่งเว็บ ให้ใส่ใน Supabase secrets เท่านั้น


อัปเดตเพิ่ม:
- favicon.svg โลโก้เว็บ
- scan.html มีปุ่ม ⛶ เต็มจอ สำหรับ kiosk mode
- scan.html มีเสียง “สแกน/บันทึกสำเร็จ”
- กด Esc เพื่อออกจาก fullscreen
