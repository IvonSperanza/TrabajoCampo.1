const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const services = [
    'Pileta',
    'Parrilla',
    'Cabañas',
    'Motorhome',
    'Electricidad',
    'WiFi',
    'Mercado',
    'Recreación'
  ];
  for (const name of services) {
    await prisma.service.upsert({
      where: { name },
      update: {},
      create: { name }
    });
  }
  console.log('✅ Seed ejecutado correctamente');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
