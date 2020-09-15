const date = new Date();
const minutes = Number(date.getMinutes());
const hours = date.getHours();

function getDate() {
  if (minutes < 15) {
    return `${hours}:00`;
  }
  if (minutes >= 15 && minutes < 30) {
    return `${hours}:15`;
  }
  if (minutes >= 30 && minutes < 45) {
    return `${hours}:30`;
  }
  if (minutes >= 45) {
    const nextH = hours + 1;
    const hour = nextH > 23 ? '00' : nextH;
    return `${hours}:45`;
  }
  return `${hours}:${minutes}`;
}

process.stdout.write(getDate());
