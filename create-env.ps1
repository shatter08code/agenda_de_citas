# Script para crear .env.local con formato correcto
# Ejecuta este script: .\create-env.ps1

$envContent = @"
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://izzskaphzvjcojzrohqr.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=sb_publishable_MsBpxD0g5VacmsNL2GPl8A_RDoFNyy7
SUPABASE_SERVICE_ROLE_KEY=sb_secret_jY1OBMnqFBXMgtuPg7kYBA_E0l5bQRO

# Telegram Bot Configuration (opcional por ahora)
TELEGRAM_BOT_TOKEN=
TELEGRAM_ADMIN_CHAT_ID=

# Site URL (opcional)
NEXT_PUBLIC_SITE_URL=http://localhost:3000
"@

$envContent | Out-File -FilePath ".env.local" -Encoding utf8 -NoNewline

Write-Host "✅ Archivo .env.local creado correctamente" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  IMPORTANTE: Verifica que las credenciales de Supabase sean correctas" -ForegroundColor Yellow
Write-Host "   - NEXT_PUBLIC_SUPABASE_URL debe ser tu URL de Supabase" -ForegroundColor Yellow
Write-Host "   - NEXT_PUBLIC_SUPABASE_ANON_KEY debe ser tu anon key" -ForegroundColor Yellow
Write-Host "   - SUPABASE_SERVICE_ROLE_KEY debe ser tu service role key" -ForegroundColor Yellow



