create extension if not exists pgcrypto;

create table public.classes (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  class_code text not null unique,
  created_at timestamptz not null default now()
);
create table public.students (
  id uuid primary key default gen_random_uuid(),
  class_id uuid not null references public.classes(id) on delete cascade,
  display_name text not null,
  pin_hash text not null,
  current_lesson int not null default 1 check(current_lesson between 1 and 10),
  created_at timestamptz not null default now()
);
create table public.attempts (
  id bigint generated always as identity primary key,
  student_id uuid not null references public.students(id) on delete cascade,
  lesson_no int not null check(lesson_no between 1 and 10),
  question_no int not null,
  area text not null,
  is_correct boolean not null,
  try_count int not null default 1,
  elapsed_ms int not null default 0,
  created_at timestamptz not null default now()
);
create index attempts_student_idx on public.attempts(student_id, created_at desc);
alter table public.classes enable row level security;
alter table public.students enable row level security;
alter table public.attempts enable row level security;
create policy "teachers manage own classes" on public.classes for all using (teacher_id=auth.uid()) with check (teacher_id=auth.uid());
create policy "teachers manage own students" on public.students for all using (exists(select 1 from public.classes c where c.id=class_id and c.teacher_id=auth.uid())) with check (exists(select 1 from public.classes c where c.id=class_id and c.teacher_id=auth.uid()));
create policy "teachers read own attempts" on public.attempts for select using (exists(select 1 from public.students s join public.classes c on c.id=s.class_id where s.id=student_id and c.teacher_id=auth.uid()));

-- PIN은 서버에서 crypt(pin, gen_salt('bf'))로 저장하고, 브라우저에는 원문이나 service role key를 보내지 않습니다.
