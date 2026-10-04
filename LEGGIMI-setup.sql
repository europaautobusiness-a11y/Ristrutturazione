-- 1) Supabase > SQL Editor: incolla ed esegui questo script

create table if not exists public.lavori_tracker (
  user_id    uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.lavori_tracker enable row level security;

create policy "Ognuno vede e modifica solo i propri dati"
  on public.lavori_tracker
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- 2) Authentication > Users > Add user: crea il tuo utente (email + password, "Auto confirm")
-- 3) Project Settings > API: copia "Project URL" e "anon public key"
--    e incollali in index.html nelle righe SUPABASE_URL e SUPABASE_KEY (in cima allo script)
-- 4) Carica la cartella su Netlify Drop (o sul tuo hosting) e installa l'app dal telefono
