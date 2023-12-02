/**
 * 格式化毫秒数为字符串，以分钟、秒和毫秒为单位。
 *
 * @param milliseconds 要格式化的毫秒数
 * @return 格式化后的字符串，格式为 "分:秒.毫秒"
 */
export function formatMilliseconds(milliseconds: number): string {
  // 将毫秒数转换为总秒数
  const totalSeconds = Math.floor(milliseconds / 1000);
  // 计算分钟数
  const minutes = Math.floor(totalSeconds / 60);
  // 计算剩余的秒数
  const seconds = totalSeconds % 60;
  // 计算剩余的毫秒数
  const millisecondsFraction = Math.floor((milliseconds % 1000) / 10);

  // 格式化分钟、秒和毫秒，确保它们都是两位数
  const formattedMinutes = String(minutes).padStart(2, '0');
  const formattedSeconds = String(seconds).padStart(2, '0');
  const formattedMilliseconds = String(millisecondsFraction).padStart(2, '0');

  // 返回格式化后的字符串
  return `${formattedMinutes}:${formattedSeconds}.${formattedMilliseconds}`;
}
