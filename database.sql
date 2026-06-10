create extension if not exists "pgcrypto";

create table if not exists public.employees (
  id uuid primary key default gen_random_uuid(),
  employee_code text not null unique,
  name text not null,
  face_data jsonb not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.attendance_logs (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid references public.employees(id),
  employee_code text not null,
  employee_name text not null,
  scan_type text not null,
  scan_time timestamptz not null default now(),
  status_text text not null,
  late_minutes int not null default 0,
  early_leave_minutes int not null default 0,
  overtime_minutes int not null default 0,
  note text,
  lat double precision,
  lng double precision,
  telegram_message_id text,
  created_at timestamptz not null default now()
);

alter table public.employees enable row level security;
alter table public.attendance_logs enable row level security;

drop policy if exists "allow read employees" on public.employees;
create policy "allow read employees" on public.employees for select to anon using (is_active = true);

drop policy if exists "allow insert employees" on public.employees;
create policy "allow insert employees" on public.employees for insert to anon with check (true);

drop policy if exists "allow insert attendance" on public.attendance_logs;
create policy "allow insert attendance" on public.attendance_logs for insert to anon with check (true);

drop policy if exists "allow read attendance" on public.attendance_logs;
create policy "allow read attendance" on public.attendance_logs for select to anon using (true);
