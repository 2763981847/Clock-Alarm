export function formatMilliseconds(milliseconds: number): string {
  const totalSeconds = Math.floor(milliseconds / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  const millisecondsFraction = Math.floor((milliseconds % 1000) / 10);

  const formattedMinutes = String(minutes).padStart(2, '0');
  const formattedSeconds = String(seconds).padStart(2, '0');
  const formattedMilliseconds = String(millisecondsFraction).padStart(2, '0');

  return `${formattedMinutes}:${formattedSeconds}.${formattedMilliseconds}`;
}

